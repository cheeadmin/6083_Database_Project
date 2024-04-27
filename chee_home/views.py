from django.db.models import ProtectedError
from django.db.utils import IntegrityError
from django.urls import reverse
from django.contrib.auth.hashers import make_password
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse, Http404, HttpResponseBadRequest
from django.db import connection, IntegrityError, transaction
from .database import get_customer_by_id
from django.contrib.auth.decorators import login_required
from chee_lessons.models import Staff
import re

# Create your views here.

from django.shortcuts import render

def index(request):
    return render(request, 'index.html')

def unauthorized(request):
    return render(request, 'unauthorized.html')

def user_login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            return redirect('home')  # Redirect to home page after successful login
        else:
            return render(request, 'login.html', {'error_message': 'Invalid username or password'})

    return render(request, 'login.html')

def signup(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        confirm_password = request.POST['confirm_password']
        email = request.POST['email']

        # Check if passwords match
        if password != confirm_password:
            return render(request, 'signup.html', {'error_message': 'Passwords do not match'})

        # Check if the username is already taken
        if User.objects.filter(username=username).exists():
            return render(request, 'signup.html', {'error_message': 'Username is already taken'})

        # Create the user
        user = User.objects.create_user(username=username, email=email, password=password)
        user.save()

        # Log the user in after signup
        user = authenticate(username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('create_customer_profile')  # Redirect to home page after successful signup
        else:
            return render(request, 'signup.html', {'error_message': 'Failed to log in after signup'})

    return render(request, 'signup.html')


@login_required
def register_staff(request):
    if not request.user.is_staff:
        messages.error(request, "Unauthorized access.")
        return redirect('home')

    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        email = request.POST['contact_details']
        role = request.POST['role']

        try:
            user = User.objects.create_user(username, email, password)
            user.first_name = first_name
            user.last_name = last_name
            user.is_staff = True  # Set True if every staff member should have access to the admin site
            user.save()

            Staff.objects.create(
                user=user,
                firstName=first_name,
                lastName=last_name,
                role=role,
                contactDetails=email
            )
            messages.success(request, "Staff member registered successfully.")
            return redirect('home')
        except IntegrityError as e:
            messages.error(request, f"Error creating staff member: {e}")
            return render(request, 'register_staff.html')

    return render(request, 'register_staff.html')

@login_required
def list_staff(request):
    if not request.user.is_staff:
        messages.error(request, "Unauthorized access.")
        return redirect('home')
    
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT s.staffID, s.firstName, s.lastName, s.contactDetails, s.role, u.username 
            FROM Staff s
            LEFT JOIN auth_user u ON s.user_id = u.id
        """)
        staff_members = cursor.fetchall()
        # Convert query result to a list of dictionaries for easier access in the template
        staff_members = [
            {
                'staffID': staff[0], 'firstName': staff[1], 'lastName': staff[2],
                'contactDetails': staff[3], 'role': staff[4], 'username': staff[5]
            } for staff in staff_members
        ]
    return render(request, 'list_staff.html', {'staff_members': staff_members})

@login_required
def edit_staff(request, staff_id):
    if not request.user.is_staff:
        messages.error(request, "Unauthorized access.")
        return redirect('home')

    # Fetch the associated user_id for the staff member
    user_id = None
    with connection.cursor() as cursor:
        cursor.execute("SELECT user_id FROM Staff WHERE staffID = %s", [staff_id])
        user_row = cursor.fetchone()
        if user_row:
            user_id = user_row[0]
    
    # If no matching staff member found, raise a 404 error
    if user_id is None:
        raise Http404('Staff member not found.')

    # Fetch the existing staff details including the username
    staff = None
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT s.staffID, s.firstName, s.lastName, s.contactDetails, s.role, u.username, u.email
            FROM Staff s
            JOIN auth_user u ON s.user_id = u.id
            WHERE s.staffID = %s
        """, [staff_id])
        staff_row = cursor.fetchone()
        if staff_row:
            staff = {
                'staffID': staff_row[0], 
                'firstName': staff_row[1], 
                'lastName': staff_row[2],
                'contactDetails': staff_row[3], 
                'role': staff_row[4],
                'username': staff_row[5],
                'email': staff_row[6]
            }

    if request.method == 'POST':
        username = request.POST['username']
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        email = request.POST['email']
        role = request.POST['role']
        
        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    # Update the auth_user table
                    cursor.execute("""
                        UPDATE auth_user SET username = %s, first_name = %s, last_name = %s, email = %s 
                        WHERE id = %s
                    """, [username, first_name, last_name, email, user_id])

                    # Update the Staff table
                    cursor.execute("""
                        UPDATE Staff SET firstName = %s, lastName = %s, contactDetails = %s, role = %s 
                        WHERE staffID = %s
                    """, [first_name, last_name, email, role, staff_id])

                messages.success(request, "Staff member updated successfully.")
                return redirect('list_staff')
        except IntegrityError as e:
            messages.error(request, f"An error occurred while updating: {e}")
            return render(request, 'edit_staff.html', {'staff': staff, 'error_message': str(e)})
    
    return render(request, 'edit_staff.html', {'staff': staff})

@login_required
def delete_staff(request, staff_id):
    if not request.user.is_staff:
        messages.error(request, "Unauthorized access.")
        return redirect('home')

    if request.method == 'POST':
        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    # Nullify the instructor_id in LessonBookings if necessary
                    cursor.execute("""
                        UPDATE LessonBookings
                        SET instructor_id = NULL
                        WHERE instructor_id IN (
                            SELECT instructorID FROM Instructors WHERE staffID = %s
                        )
                    """, [staff_id])

                    # Delete from Instructors if necessary
                    cursor.execute("""
                        DELETE FROM Instructors WHERE staffID = %s
                    """, [staff_id])

                    # Delete the staff member
                    cursor.execute("""
                        DELETE FROM Staff WHERE staffID = %s
                    """, [staff_id])

                messages.success(request, "Staff member deleted successfully.")
                return redirect('list_staff')

        except Exception as e:
            # If an error occurs, the transaction will be rolled back
            messages.error(request, f"An error occurred while deleting: {e}")
            return render(request, 'delete_staff.html', {'staff_id': staff_id})

    # GET request or any other method
    return render(request, 'delete_staff.html', {'staff_id': staff_id})

@login_required
def add_staff(request):
    if not request.user.is_staff:
        messages.error(request, "Unauthorized access.")
        return redirect('home')

    if request.method == 'POST':
        username = request.POST.get('username')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        role = request.POST.get('role')
        contact_details = request.POST.get('contact_details')
        email = request.POST.get('email')
        password = make_password(request.POST.get('password'))

        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    # Create a new user in the auth_user table
                    cursor.execute("""
                        INSERT INTO auth_user (
                            username, first_name, last_name, email, password,
                            is_superuser, is_staff, is_active, date_joined
                        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, NOW())
                    """, [username, first_name, last_name, email, password,
                          False, True, True])
                    user_id = cursor.lastrowid

                    # Create a new staff member in the Staff table
                    cursor.execute("""
                        INSERT INTO Staff (
                            firstName, lastName, role, contactDetails, user_id
                        ) VALUES (%s, %s, %s, %s, %s)
                    """, [first_name, last_name, role, contact_details, user_id])

                messages.success(request, "Staff member added successfully.")
                return redirect(reverse('list_staff'))
        except Exception as e:
            messages.error(request, f"An error occurred: {e}")

    # If GET request or POST with errors, render the form page
    return render(request, 'add_staff.html')

@login_required
def home_view(request):
    if request.user.is_staff:
        return render(request, 'home_staff.html')
    else:
        return render(request, 'home.html')
    
def show_customer(request, customer_id):
    customer = get_customer_by_id(customer_id)
    if customer:
        return HttpResponse(customer)
    else:
        return HttpResponse("Customer not found", status=404)

@login_required
def create_customer_profile(request):
    if request.method == 'POST':
        firstName = request.POST.get('firstName').strip()
        lastName = request.POST.get('lastName').strip()
        contactInfo = request.POST.get('contactInfo').strip()
        paymentDetails = request.POST.get('paymentDetails')
        user_id = request.user.id

        # Basic validation
        if not firstName or not lastName:
            return HttpResponseBadRequest("First name and last name cannot be empty.")
        if not re.match(r'^\+?1?\d{9,15}$', contactInfo):  # This is a simple regex for international phone numbers
            return HttpResponseBadRequest("Invalid phone number format.")

        with connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO Customer (firstName, lastName, contactInfo, PaymentDetails, user_id)
                VALUES (%s, %s, %s, %s, %s)
            """, [firstName, lastName, contactInfo, paymentDetails, user_id])

        return redirect('home')

    return render(request, 'profile.html')

@login_required
def read_customer_profiles(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT id, firstName, lastName, contactInfo, paymentDetails FROM Customer WHERE user_id = %s", [request.user.id])
        profiles = cursor.fetchall()
        print(profiles)  # Debug: Print the profiles to the console.
    return render(request, 'read_profiles.html', {'profiles': profiles})


@login_required
def update_customer_profile(request, profile_id):
    if request.method == 'POST':
        firstName = request.POST.get('firstName')
        lastName = request.POST.get('lastName')
        contactInfo = request.POST.get('contactInfo')
        paymentDetails = request.POST.get('paymentDetails')
        
        # Basic validation
        if not firstName or not lastName:
            return HttpResponseBadRequest("First name and last name cannot be empty.")
        if not re.match(r'^\+?1?\d{9,15}$', contactInfo):  # This is a simple regex for international phone numbers
            return HttpResponseBadRequest("Invalid phone number format.")

        with connection.cursor() as cursor:
            cursor.execute("""
                UPDATE Customer SET firstName = %s, lastName = %s, contactInfo = %s, paymentDetails = %s
                WHERE id = %s AND user_id = %s
            """, [firstName, lastName, contactInfo, paymentDetails, profile_id, request.user.id])
        return redirect('read_customer_profiles')
    
    with connection.cursor() as cursor:
        cursor.execute("SELECT id, firstName, lastName, contactInfo, paymentDetails FROM Customer WHERE id = %s AND user_id = %s", [profile_id, request.user.id])
        profile = cursor.fetchone()
        if profile is None:
            raise Http404('Profile not found.')

    return render(request, 'update_profile.html', {'profile': profile})

@login_required
def delete_customer_profile(request, profile_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            cursor.execute("DELETE FROM Customer WHERE id = %s AND user_id = %s", [profile_id, request.user.id])
        return redirect('read_customer_profiles')

    with connection.cursor() as cursor:
        cursor.execute("SELECT id, firstName, lastName FROM Customer WHERE id = %s AND user_id = %s", [profile_id, request.user.id])
        profile = cursor.fetchone()
        if profile is None:
            raise Http404('Profile not found.')

    return render(request, 'delete_profile.html', {'profile': profile})

@login_required
def user_view(request):
    # Logic to pass necessary context data to the template
    return render(request, 'user.html')