from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.db import connection, transaction, DatabaseError
from datetime import datetime
from django.urls import reverse
from .models import Equipment, Customer
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods

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
        customer_id = request.user.customer_id  

        rental_date_obj = datetime.strptime(rental_date, '%Y-%m-%d')
        return_date_obj = datetime.strptime(return_date, '%Y-%m-%d')
        rental_period = (return_date_obj - rental_date_obj).days
        
        with connection.cursor() as cursor:
            cursor.execute("SELECT daily_price FROM mydb.Equipment WHERE equipmentID = %s", [equipment_id])
            result = cursor.fetchone()
            if result:
                daily_price = result[0]
                total_price = rental_period * daily_price

                cursor.execute("SELECT MAX(rentalID) FROM mydb.Rental")
                max_id_result = cursor.fetchone()
                next_rental_id = max_id_result[0] + 1 if max_id_result[0] else 1

                cursor.execute("""
                    INSERT INTO mydb.Rental (rentalID, rentalDate, returnDate, Price, equipmentID, customerId)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """, [next_rental_id, rental_date, return_date, total_price, equipment_id, customer_id])
                
                connection.commit()

                return HttpResponseRedirect('/rental-cart/')
            else:
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
        with transaction.atomic():  # Begin a transaction block
            customer = Customer.objects.filter(user=user).first()
            if not customer:
                raise Customer.DoesNotExist
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
        customer = Customer.objects.filter(user=request.user).first()
        if not customer:
            raise Customer.DoesNotExist

        rentals = []
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT r.rentalID, e.Brand, e.Description, r.rentalDate, r.returnDate, r.Price
                FROM Rental r
                JOIN Equipment e ON r.equipmentID = e.equipmentID
                WHERE r.customerId = %s
            """, [customer.id])
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
        messages.error(request, "No customer associated with this user.")

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
        
        messages.success(request, 'Equipment returned successfully.')
        return redirect('list_rented')  # Redirect to the list of rented items

    messages.error(request, 'Invalid request method.')
    return redirect('list_rented')


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

@login_required
def edit_return_date(request, rental_id):
    if request.method == 'POST':
        new_return_date = request.POST.get('new_return_date')

        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    # Execute the SQL to update the return date
                    cursor.execute("""
                        UPDATE Rental
                        SET returnDate = %s
                        WHERE rentalID = %s
                    """, [new_return_date, rental_id])
            return redirect('list_rented')
        except Exception as e:
            return render(request, 'edit_return_date.html', {
                'error_message': 'An error occurred while updating the return date. Please try again.',
                'rental_id': rental_id,
                'return_date': new_return_date
            })

    else:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT returnDate
                FROM Rental
                WHERE rentalID = %s
            """, [rental_id])
            row = cursor.fetchone()

        if row:
            return render(request, 'edit_return_date.html', {
                'rental_id': rental_id,
                'return_date': row[0]
            })
        else:
            return render(request, 'edit_return_date.html', {
                'error_message': 'Rental not found.',
                'rental_id': rental_id
            })

@login_required
def update_return_date(request, rental_id):
    if request.method == 'POST':
        new_return_date = request.POST.get('new_return_date')

        with connection.cursor() as cursor:
            cursor.execute("""
                UPDATE Rental SET returnDate = %s WHERE rentalID = %s
            """, [new_return_date, rental_id])
            connection.commit()
            messages.success(request, 'Return date updated successfully.')
            return redirect('list_rented')
    else:
        messages.error(request, 'An error occurred while updating the return date.')

    return redirect('edit_return_date', rental_id=rental_id)
