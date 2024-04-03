from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.db import connection, transaction
from datetime import datetime
from django.urls import reverse
from .models import Equipment
from django.core.paginator import Paginator

@login_required
def equipment_list(request):
    with connection.cursor() as cursor:
        # Adjust the SQL query to match your current table structure.
        cursor.execute("""
            SELECT equipmentID, Brand, Description, typeID, Availability, 
                   LastMaintenance, Price, Size 
            FROM mydb.Equipment
        """)
        equipments = cursor.fetchall()
    # Adjust the context variable and template as necessary.
    return render(request, 'equipment_list.html', {'equipments': equipments})

@login_required
def add_to_rental_cart(request, equipment_id):
    if request.method == 'POST':
        rental_date = request.POST.get('rental_date')
        return_date = request.POST.get('return_date')
        customer_id = request.user.customer_id  # Assuming a user is linked to a customer

        # Convert dates to datetime objects to calculate the rental period
        rental_date_obj = datetime.strptime(rental_date, '%Y-%m-%d')
        return_date_obj = datetime.strptime(return_date, '%Y-%m-%d')
        rental_period = (return_date_obj - rental_date_obj).days
        
        # Assuming the Equipment table has a column named 'daily_price'
        # Fetch the daily price of the equipment using raw SQL
        with connection.cursor() as cursor:
            cursor.execute("SELECT daily_price FROM mydb.Equipment WHERE equipmentID = %s", [equipment_id])
            result = cursor.fetchone()
            if result:
                daily_price = result[0]
                total_price = rental_period * daily_price

                # Generate a new rental ID or use auto increment if configured
                # Since it is not auto-incrementing according to the given schema, you might want to calculate the next ID
                cursor.execute("SELECT MAX(rentalID) FROM mydb.Rental")
                max_id_result = cursor.fetchone()
                next_rental_id = max_id_result[0] + 1 if max_id_result[0] else 1

                # Insert the new rental into the database using raw SQL
                cursor.execute("""
                    INSERT INTO mydb.Rental (rentalID, rentalDate, returnDate, Price, equipmentID, customerId)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """, [next_rental_id, rental_date, return_date, total_price, equipment_id, customer_id])
                
                # Commit the transaction
                connection.commit()

                # Redirect to a new URL to show the rental cart or confirmation
                return HttpResponseRedirect('/rental-cart/')
            else:
                # Handle the case where the equipment's daily price is not found
                return render(request, 'error.html', {'error': 'Daily price not found for the selected equipment'})

@login_required
@login_required
def list_skis(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT Brand, Description, LastMaintenance, Size, Availability, equipmentID FROM mydb.Equipment WHERE typeID = 1")
        skis_list = cursor.fetchall()
    
    # Log the structure of the first ski item, if available
    if skis_list:
        print("Structure of ski item:", skis_list[0])

    paginator = Paginator(skis_list, 20)  # Shows 20 skis per page.
    page_number = request.GET.get('page')
    skis = paginator.get_page(page_number)

    return render(request, 'list_skis.html', {'skis': skis})

@login_required
def list_snowboards(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT Brand, Description, LastMaintenance, Size, Availability FROM mydb.Equipment WHERE typeID = 2")
        snowboards_list = cursor.fetchall()

    paginator = Paginator(snowboards_list, 20)  # Shows 20 snowboards per page.
    page_number = request.GET.get('page')
    snowboards = paginator.get_page(page_number)

    return render(request, 'list_snowboards.html', {'snowboards': snowboards})

@login_required
@login_required
def rent_equipment(request, equipment_id):
    if request.method == 'POST':
        # Begin your database transaction
        with connection.cursor() as cursor:
            # SQL to check if the equipment is available for rent
            cursor.execute("SELECT Availability FROM Equipment WHERE equipmentID = %s", [equipment_id])
            available = cursor.fetchone()

            if available and available[0]:
                # SQL to update equipment to unavailable
                cursor.execute("UPDATE Equipment SET Availability = 0 WHERE equipmentID = %s", [equipment_id])
                
                # SQL to insert a new rental record
                cursor.execute("INSERT INTO Rental (rentalDate, equipmentID, customerID) VALUES (NOW(), %s, %s)", [equipment_id, request.user.id])
                
                # Commit the changes
                connection.commit()
                return redirect(reverse('some_view_to_confirm_rental'))
            else:
                # Equipment is not available
                # Redirect to an error page or show an error message
                pass

    # If not POST or if equipment is not available, redirect to equipment list
    return redirect(reverse('equipment_list'))

@login_required
def return_equipment(request, equipment_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            # Wrap the SQL operations in a transaction to ensure data integrity
            with transaction.atomic():
                # Update the availability status of the equipment
                cursor.execute("UPDATE Equipment SET Availability = TRUE WHERE equipmentID = %s", [equipment_id])
                
                # Update the return date of the rental record
                cursor.execute("""
                    UPDATE Rental 
                    SET returnDate = CURRENT_DATE 
                    WHERE equipmentID = %s AND returnDate IS NULL
                """, [equipment_id])

        # Redirect to the equipment list page
        return redirect('equipment_list')  # Ensure you have a URL with the name 'equipment_list'
    else:
        # If not POST, redirect to equipment list or show an error message
        return redirect('equipment_list')