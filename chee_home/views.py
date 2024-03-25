from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.db import connection
from django.http import HttpResponse
from .database import get_customer_by_id
from django.contrib.auth.decorators import login_required

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
            return redirect('create_customer_profile')  # Redirect to home page after successful login
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

# def my_custom_sql_query(request):
#     with connection.cursor() as cursor:
#         cursor.execute("SELECT * FROM my_table WHERE column = %s", [value])
#         result = cursor.fetchone()

#     return HttpResponse(result)

# views.py

def home_view(request):
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
        firstName = request.POST.get('firstName')
        lastName = request.POST.get('lastName')
        contactInfo = request.POST.get('contactInfo')
        paymentDetails = request.POST.get('paymentDetails')
        user_id = request.user.id  # Assuming you're linking Customer to the User

        with connection.cursor() as cursor:
            # Corrected SQL to include user_id and matching column names to your schema
            cursor.execute("""
                INSERT INTO Customer (firstName, lastName, contactInfo, PaymentDetails, user_id)
                VALUES (%s, %s, %s, %s, %s)
            """, [firstName, lastName, contactInfo, paymentDetails, user_id])

        return redirect('home')  # Make sure 'home' is a valid URL name in your urls.py

    return render(request, 'profile.html')