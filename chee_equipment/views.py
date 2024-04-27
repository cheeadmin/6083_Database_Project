from django.utils import timezone
from django.urls import reverse
from datetime import datetime
from django.contrib import messages
from django.http import HttpResponse, HttpResponseBadRequest, HttpResponseNotFound
from django.contrib import messages
from django.shortcuts import render, redirect
from django.core.exceptions import PermissionDenied
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, Http404
from django.contrib.auth.decorators import login_required
from django.db import connection, transaction
from .models import Equipment


@login_required
def list_equipment(request):
    if not request.user.is_staff:
        raise PermissionDenied

    with connection.cursor() as cursor:
        cursor.execute("SELECT equipmentID, Brand, Description, typeID, Availability, LastMaintenance, Price, Size FROM Equipment")
        equipments = cursor.fetchall()

    equipments_list = [
        {
            'equipmentID': eq[0],
            'Brand': eq[1],
            'Description': eq[2],
            'typeID': eq[3],
            'Availability': eq[4],
            'LastMaintenance': eq[5].strftime('%Y-%m-%d') if eq[5] else None,
            'Price': eq[6],
            'Size': eq[7]
        }
        for eq in equipments
    ]

    return render(request, 'list_equipment.html', {'equipments': equipments_list})

@login_required
def add_equipment(request):
    if request.method == 'POST':
        brand = request.POST.get('brand')
        description = request.POST.get('description')
        typeID = request.POST.get('typeID')
        availability = request.POST.get('availability')
        lastMaintenance = request.POST.get('lastMaintenance')
        price = request.POST.get('price')
        size = request.POST.get('size')

        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO Equipment (Brand, Description, typeID, Availability, LastMaintenance, Price, Size) VALUES (%s, %s, %s, %s, %s, %s, %s)", [brand, description, typeID, availability, lastMaintenance, price, size])
        return redirect('chee_equipment:list_equipment')
    return render(request, 'add_equipment.html')

@login_required
def edit_equipment(request, equipment_id):
    if not request.user.is_staff:
        raise PermissionDenied
    
    if request.method == 'GET':
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM Equipment WHERE equipmentID = %s", [equipment_id])
            equipment = cursor.fetchone()
            if not equipment:
                return HttpResponseNotFound('Equipment not found')

            equipment_dict = {
                'equipmentID': equipment[0],
                'Brand': equipment[1],
                'Description': equipment[2],
                'typeID': equipment[3],
                'Availability': equipment[4],
                'LastMaintenance': equipment[5].strftime('%Y-%m-%d') if equipment[5] else None,
                'Price': equipment[6],
                'Size': equipment[7]
            }
            return render(request, 'edit_equipment.html', {'equipment': equipment_dict})
    
    elif request.method == 'POST':
        brand = request.POST.get('Brand')
        description = request.POST.get('Description')
        type_id = request.POST.get('typeID')
        availability = request.POST.get('Availability') == '1'
        last_maintenance = request.POST.get('LastMaintenance')
        price = request.POST.get('Price')
        size = request.POST.get('Size')

        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    UPDATE Equipment
                    SET Brand = %s, Description = %s, typeID = %s, Availability = %s, 
                        LastMaintenance = %s, Price = %s, Size = %s
                    WHERE equipmentID = %s
                """, (brand, description, type_id, availability, last_maintenance, price, size, equipment_id))
            messages.success(request, "Equipment updated successfully.")
            return redirect('chee_equipment:list_equipment')
        except Exception as e:
            messages.error(request, f"An error occurred while updating the equipment: {e}")
            return redirect('chee_equipment:edit_equipment', equipment_id=equipment_id)

    else:
        return HttpResponseBadRequest("Invalid request method.")

@login_required
def delete_equipment(request, equipment_id):
    if not request.user.is_staff:
        raise PermissionDenied

    if request.method == 'POST':
        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    cursor.execute("DELETE FROM Equipment WHERE equipmentID = %s", [equipment_id])
                messages.success(request, 'Equipment deleted successfully!')
        except Exception as e:
            # If there is any exception, rollback the transaction and show an error message.
            messages.error(request, f'Error deleting equipment: {e}')
        
        return redirect('chee_equipment:list_equipment')

    return HttpResponseBadRequest("Invalid request method.")

@login_required
def add_equipment_to_maintenance(request, equipment_id):
    if not request.user.is_staff:
        raise PermissionDenied

    if request.method == 'POST':
        try:
            with connection.cursor() as cursor:
                # Call the stored procedure to update the equipment's availability
                cursor.execute("CALL AddEquipmentToMaintenance(%s)", [equipment_id])
                
                # Insert the maintenance record if the stored procedure does not already do this
                current_date = datetime.now().strftime('%Y-%m-%d')
                maintenance_type = 'Scheduled'  # Or get this value from the request
                
                cursor.execute(
                    "INSERT INTO EquipmentMaintenance (maintenanceDate, maintenanceType, equipmentID) VALUES (%s, %s, %s)",
                    [current_date, maintenance_type, equipment_id]
                )
                
            messages.success(request, 'Equipment added to maintenance successfully.')
        except Exception as e:
            # Make sure to catch the specific exception if possible, instead of a general exception
            messages.error(request, f'Error adding equipment to maintenance: {e}')
        finally:
            # It is good practice to close the cursor when done
            cursor.close()
        
        return redirect('chee_equipment:list_maintenance_equipments')
    
    else:
        return HttpResponseBadRequest("Invalid request method.")


@login_required
def delete_equipment_from_maintenance(request, maintenance_id):
    if not request.user.is_staff:
        raise PermissionDenied

    if request.method == 'POST':
        try:
            with connection.cursor() as cursor:
                cursor.execute("DELETE FROM EquipmentMaintenance WHERE maintenanceID = %s", [maintenance_id])
                messages.success(request, 'Maintenance record deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting maintenance record: {str(e)}')
        return redirect('chee_equipment:equipment_maintenance')

    else:
        return HttpResponseBadRequest("Invalid request method.")

@login_required
def list_maintenance_equipments(request):
    if not request.user.is_staff:
        raise PermissionDenied

    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT equipmentID, Brand, Description, typeID, Availability, LastMaintenance, Price, Size 
                FROM Equipment 
                WHERE Availability = 1
            """)
            available_equipments = [
                {
                    'equipmentID': row[0],
                    'Brand': row[1],
                    'Description': row[2],
                    'typeID': row[3],
                    'Availability': row[4],
                    'LastMaintenance': row[5].strftime('%Y-%m-%d') if row[5] else None,
                    'Price': row[6],
                    'Size': row[7]
                } for row in cursor.fetchall()
            ]
    except Exception as e:
        messages.error(request, f'Error retrieving available equipment: {e}')
        available_equipments = []

    #print(available_equipments)  # Debugging: Print to console to verify
    
    return render(request, 'maintenance_equipments.html', {'equipments': available_equipments})

@login_required
def list_equipment_in_maintenance(request):
    if not request.user.is_staff:
        raise PermissionDenied

    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT eq.equipmentID, eq.Brand, eq.Description, eq.TypeID, eq.LastMaintenance, eq.Price, eq.Size, em.maintenanceID, em.maintenanceDate
            FROM Equipment eq
            JOIN EquipmentMaintenance em ON eq.equipmentID = em.equipmentID
            WHERE eq.Availability = 0
        """)
        maintenance_list = cursor.fetchall()

    context = {
        'maintenances': [
            {
                'equipmentID': eq[0],
                'Brand': eq[1],
                'Description': eq[2],
                'TypeID': eq[3],
                'LastMaintenance': eq[4].strftime('%Y-%m-%d') if eq[4] else None,
                'Price': eq[5],
                'Size': eq[6],
                'maintenanceID': eq[7],
                'MaintenanceDate': eq[8].strftime('%Y-%m-%d') if eq[8] else None,  # Add the MaintenanceDate field
            }
            for eq in maintenance_list
        ]
    }

    return render(request, 'equipment_in_maintenance_list.html', context)


@login_required
def complete_maintenance(request, maintenance_id):
    if not request.user.is_staff:
        raise PermissionDenied

    if request.method == 'POST':
        try:
            with connection.cursor() as cursor:
                # Update the equipment to set its availability back to 1
                cursor.execute("""
                    UPDATE Equipment e
                    JOIN EquipmentMaintenance em ON e.equipmentID = em.equipmentID
                    SET e.Availability = 1
                    WHERE em.maintenanceID = %s
                """, [maintenance_id])

                # Then delete the maintenance record
                cursor.execute("""
                    DELETE FROM EquipmentMaintenance WHERE maintenanceID = %s
                """, [maintenance_id])

            messages.success(request, 'Maintenance completed and equipment is now available.')

        except Exception as e:
            messages.error(request, f'Error completing maintenance: {e}')
        
        return redirect(reverse('chee_equipment:list_equipment_in_maintenance'))
    else:
        messages.error(request, 'Invalid request method.')
        return redirect(reverse('chee_equipment:list_equipment_in_maintenance'))

@login_required
def edit_maintenance_date(request, maintenance_id):
    if not request.user.is_staff:
        raise PermissionDenied
    
    # Retrieve the current maintenance record
    with connection.cursor() as cursor:
        cursor.execute("SELECT maintenanceID, maintenanceDate FROM EquipmentMaintenance WHERE maintenanceID = %s", [maintenance_id])
        maintenance = cursor.fetchone()
        if not maintenance:
            return HttpResponseNotFound('Maintenance record not found')

    if request.method == 'POST':
        # Process the form submission
        new_maintenance_date = request.POST.get('new_maintenance_date')
        # Update the maintenance record using raw SQL
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    UPDATE EquipmentMaintenance
                    SET maintenanceDate = %s
                    WHERE maintenanceID = %s
                """, [new_maintenance_date, maintenance_id])
            messages.success(request, "Maintenance date updated successfully.")
            return redirect('list_equipment_in_maintenance')
        except Exception as e:
            messages.error(request, f"An error occurred: {str(e)}")
            # Optionally, redirect to a failure page or re-render the edit form with an error message.
            return render(request, 'edit_maintenance_date.html', {'maintenance': maintenance, 'error': str(e)})
    else:
        # Display the form with current data
        return render(request, 'edit_maintenance_date.html', {'maintenance': maintenance})
