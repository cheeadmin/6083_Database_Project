from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponse, Http404, HttpResponseBadRequest
from django.db import connection, IntegrityError
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
    staff_members = Staff.objects.select_related('user').all()
    return render(request, 'list_staff.html', {'staff_members': staff_members})

@login_required
def add_staff(request):
    if request.method == 'POST':
        # Collect form data
        username = request.POST['username']
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        role = request.POST['role']
        contact_details = request.POST['contact_details']
        password = request.POST['password']

        # Create User and Staff records
        user = User.objects.create_user(username=username, first_name=first_name, last_name=last_name, password=password)
        Staff.objects.create(user=user, firstName=first_name, lastName=last_name, role=role, contactDetails=contact_details)

        return redirect('list_staff')

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