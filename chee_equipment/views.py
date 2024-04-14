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
    equipment = get_object_or_404(Equipment, pk=equipment_id)
    equipment.delete()
    return redirect('chee_equipment:list_equipment')
