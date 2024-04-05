from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.db import connection, transaction, DatabaseError
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
def list_skis(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT equipmentID, Brand, Description, LastMaintenance, Size, Availability 
            FROM mydb.Equipment 
            WHERE typeID = 1 AND Availability = 1
        """)
        skis_list = cursor.fetchall()
    return render(request, 'list_skis.html', {'skis': skis_list})


@login_required
def list_snowboards(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT equipmentID, Brand, Description, LastMaintenance, Size, Availability FROM mydb.Equipment WHERE typeID = 2 AND Availability = 1")
        snowboards_list = cursor.fetchall()
    
    # Return the list to the template
    return render(request, 'list_snowboards.html', {'snowboards': snowboards_list})

@login_required
def rent_equipment(request, equipment_id):
    print(f"Attempting to rent equipment with ID: {equipment_id}")  # Debug log
    if request.method == 'POST':
        with connection.cursor() as cursor:
            cursor.execute("SELECT Availability FROM mydb.Equipment WHERE equipmentID = %s", [equipment_id])
            available = cursor.fetchone()
            if available and available[0]:
                cursor.execute("UPDATE mydb.Equipment SET Availability = 0 WHERE equipmentID = %s", [equipment_id])
                connection.commit()
                messages.success(request, "Equipment rented successfully.")
                return redirect('list_skis')
            else:
                messages.error(request, "This equipment is not available for rent.")
                return redirect('list_skis')
    else:
        messages.error(request, "Invalid request.")
        return redirect('list_skis')

@login_required
def return_equipment(request, equipment_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            cursor.execute("UPDATE mydb.Equipment SET Availability = 1 WHERE equipmentID = %s", [equipment_id])
            connection.commit()
        return redirect('list_skis')
    return redirect('list_skis')  # Redirect here if not POST or something went wrong.

@login_required
def rental_error(request):
    # You can pass more context or determine the error type if you have different error cases
    return render(request, 'rental_error.html', {'error_message': 'The equipment is not available for rent.'})