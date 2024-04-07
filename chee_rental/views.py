from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.db import connection, transaction, DatabaseError
from datetime import datetime
from django.urls import reverse
from .models import Equipment, Customer
from django.views.decorators.csrf import csrf_exempt

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
    # Add equipment to session-based cart
    cart = request.session.get('cart', {})
    if str(equipment_id) not in cart:
        cart[str(equipment_id)] = {'quantity': 1}  # assuming quantity is needed, otherwise just set to 1
    request.session['cart'] = cart
    messages.success(request, "Item added to cart.")
    return redirect('rental_cart')  # Redirect to the cart confirmation page

@login_required
def return_equipment(request, equipment_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            cursor.execute("SELECT typeID FROM Equipment WHERE equipmentID = %s", [equipment_id])
            typeID = cursor.fetchone()[0]

            cursor.execute("UPDATE Equipment SET Availability = 1 WHERE equipmentID = %s", [equipment_id])
            cursor.execute("DELETE FROM Rental WHERE equipmentID = %s", [equipment_id])
            connection.commit()

            return redirect('list_snowboards' if typeID == 2 else 'list_skis')
    # If it's not a POST request or something went wrong, redirect to home
    return redirect('home')


@login_required
def rental_error(request):
    # You can pass more context or determine the error type if you have different error cases
    return render(request, 'rental_error.html', {'error_message': 'The equipment is not available for rent.'})

@login_required
def add_to_cart(request, equipment_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            cursor.execute("SELECT Price, typeID FROM Equipment WHERE equipmentID = %s", [equipment_id])
            result = cursor.fetchone()
        if result:
            price, typeID = result
            # Convert Decimal to string before storing in session
            cart = request.session.get('cart', {})
            cart[str(equipment_id)] = {'typeID': typeID, 'price': str(price)}
            request.session['cart'] = cart
            messages.success(request, "Item added to cart.")
        else:
            messages.error(request, "Item not found.")
        return HttpResponseRedirect(reverse('show_cart'))

@login_required
def show_cart(request):
    cart = request.session.get('cart', {})
    if not cart:
        messages.info(request, "Your cart is empty.")
        return redirect('list_skis')  # or some other page you'd like to redirect to

    equipment_ids = cart.keys()
    placeholders = ', '.join(['%s'] * len(equipment_ids))
    with connection.cursor() as cursor:
        cursor.execute(f"SELECT * FROM mydb.Equipment WHERE equipmentID IN ({placeholders})", list(equipment_ids))
        items = cursor.fetchall()

    return render(request, 'rental_cart.html', {'items': items})

@login_required
def remove_from_cart(request, equipment_id):
    cart = request.session.get('cart', {})
    if str(equipment_id) in cart:
        del cart[str(equipment_id)]
        request.session['cart'] = cart
        messages.success(request, "Item removed from cart.")
    else:
        messages.error(request, "Item not found in cart.")
    return redirect('show_cart')

@login_required
def finalize_rental(request):
    cart = request.session.get('cart', {})
    if not cart:
        messages.error(request, "Your cart is empty.")
        return redirect('rental_cart')

    user = request.user
    try:
        customer = Customer.objects.get(user=user)
        customer_id = customer.id
        with connection.cursor() as cursor:
            for equipment_id, details in cart.items():
                cursor.execute("SELECT MAX(rentalID) FROM Rental")
                max_rental_id = cursor.fetchone()[0]
                next_rental_id = max_rental_id + 1 if max_rental_id is not None else 1
                
                # Calculate total price based on some business logic
                total_price = details['price']  # Replace with actual calculation if needed

                cursor.execute("""
                    INSERT INTO Rental (rentalID, rentalDate, returnDate, Price, equipmentID, customerId)
                    VALUES (%s, CURDATE(), CURDATE() + INTERVAL 1 DAY, %s, %s, %s)
                """, [next_rental_id, total_price, equipment_id, customer_id])
                
                cursor.execute("""
                    UPDATE Equipment SET Availability = 0 WHERE equipmentID = %s
                """, [equipment_id])

            connection.commit()

        request.session['cart'] = {}
        messages.success(request, "Thank you for renting with us!")
        # Redirect to the ski list if all items in cart are skis; otherwise, redirect to snowboards
        typeID = cart[next(iter(cart))]['typeID']
        return redirect('list_skis' if typeID == 1 else 'list_snowboards')

    except Customer.DoesNotExist:
        messages.error(request, "You need to be associated with a customer to rent equipment.")
        return redirect('rental_cart')


@login_required
def list_rented(request):
    try:
        # Retrieve the customer object associated with the current user
        customer = Customer.objects.get(user=request.user)
        customer_id = customer.id
        print(f"Customer ID: {customer_id}")  # Debug: Print the customer ID to the console

        rentals = []
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT r.rentalID, e.Brand, e.Description, r.rentalDate, r.returnDate, r.Price
                FROM Rental r
                JOIN Equipment e ON r.equipmentID = e.equipmentID
                WHERE r.customerId = %s
            """, [customer_id])
            rentals_raw = cursor.fetchall()
        
        rentals = [
            {
                'rentalID': rental[0],
                'brand': rental[1],
                'description': rental[2],  # Using 'description' field as per your schema
                'rentalDate': rental[3].strftime('%Y-%m-%d') if rental[3] else '',
                'returnDate': rental[4].strftime('%Y-%m-%d') if rental[4] else '',
                'price': rental[5] if rental[5] else 'N/A'  # Handle NULL prices
            } for rental in rentals_raw
        ]

    except Customer.DoesNotExist:
        print("The current user is not associated with a customer.")
        rentals = []
    except DatabaseError as e:
        print(e)  # Debug: Print the error to the console
        rentals = []

    print(rentals)  # Debug: Print the rentals list to the console
    return render(request, 'list_rented.html', {'rentals': rentals})

@csrf_exempt
@login_required
def return_rental(request, rental_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            # Update equipment availability
            cursor.execute("""
                UPDATE Equipment e
                JOIN Rental r ON e.equipmentID = r.equipmentID
                SET e.Availability = 1
                WHERE r.rentalID = %s
            """, [rental_id])
            
            # Delete the rental record
            cursor.execute("DELETE FROM Rental WHERE rentalID = %s", [rental_id])
            
            # Commit the changes
            connection.commit()
        
        return redirect('list_rented')  # Redirect to the list of rented skis

@login_required
def list_rented_snowboards(request):
    try:
        customer = Customer.objects.get(user=request.user)
        customer_id = customer.id

        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT r.rentalID, e.Brand, e.Description, r.rentalDate, r.returnDate, r.Price
                FROM Rental r
                JOIN Equipment e ON r.equipmentID = e.equipmentID
                WHERE r.customerId = %s AND e.typeID = 2
            """, [customer_id])
            rentals_raw = cursor.fetchall()

        rentals = [
            {
                'rentalID': rental[0],
                'brand': rental[1],
                'description': rental[2],
                'rentalDate': rental[3].strftime('%Y-%m-%d') if rental[3] else '',
                'returnDate': rental[4].strftime('%Y-%m-%d') if rental[4] else '',
                'price': rental[5] if rental[5] else 'N/A'
            } for rental in rentals_raw
        ]

    except Customer.DoesNotExist:
        rentals = []
    except DatabaseError as e:
        rentals = []

    return render(request, 'list_rented_snowboards.html', {'rentals': rentals})

@csrf_exempt
@login_required
def return_snowboard_rental(request, rental_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            # First, check if the rented equipment is a snowboard
            cursor.execute("""
                SELECT e.typeID FROM Equipment e
                JOIN Rental r ON e.equipmentID = r.equipmentID
                WHERE r.rentalID = %s
            """, [rental_id])
            typeID = cursor.fetchone()[0]

            if typeID != 2:  # Only proceed if the typeID corresponds to snowboards
                messages.error(request, "This item is not a snowboard.")
                return redirect('list_rented_snowboards')

            # Proceed to update availability and delete the rental record
            cursor.execute("""
                UPDATE Equipment e
                JOIN Rental r ON e.equipmentID = r.equipmentID
                SET e.Availability = 1
                WHERE r.rentalID = %s
            """, [rental_id])
            cursor.execute("DELETE FROM Rental WHERE rentalID = %s", [rental_id])
            connection.commit()
        
        return redirect('list_rented_snowboards')
