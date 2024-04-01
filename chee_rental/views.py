from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.db import connection
from datetime import datetime
from .models import Equipment

def equipment_list(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT equipmentID, Brand, `Condition` FROM mydb.Equipment")
        equipments = cursor.fetchall()
    
    equipments_list = []
    for equipment in equipments:
        equipments_list.append({
            'equipmentID': equipment[0],
            'Brand': equipment[1],
            'Condition': equipment[2]
        })

    return render(request, 'equipment_list.html', {'equipments': equipments_list})

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