from django.contrib import messages
from django.core.exceptions import PermissionDenied
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.db import connection, DatabaseError
from datetime import date

@login_required
def business_report(request):
    if not request.user.is_staff:
        raise PermissionDenied

    # This view simply renders a template that includes links to various business reports.
    return render(request, 'business_report.html')

@login_required
def customer_lesson_report(request):
    if not request.user.is_staff:
        raise PermissionDenied

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM CustomerLessonBookings")
        report_data = cursor.fetchall()

    context = {
        'report_data': report_data,
    }
    return render(request, 'customer_lesson_report.html', context)

@login_required
def daily_rental_income_report(request):
    # Assume we want the income for today's date, or pass in another date as a parameter
    today_date = date.today().strftime('%Y-%m-%d')  # Correctly use date.today() from the date class
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT GetDailyRentalIncome(%s)", [today_date])
            result = cursor.fetchone()
            income = result[0] if result else 0  # If no result, then income is 0
    except DatabaseError as e:
        messages.error(request, f"Database error: {e}")
        income = "Error"

    context = {
        'date': today_date,
        'income': income
    }
    return render(request, 'daily_rental_income_report.html', context)

@login_required
def daily_lesson_count_report(request):
    if not request.user.is_staff:
        raise PermissionDenied
    
    with connection.cursor() as cursor:
        cursor.execute("SELECT Date, LessonCount FROM DailyLessonCount ORDER BY Date DESC")
        daily_counts = cursor.fetchall()

    context = {
        'daily_counts': daily_counts,
    }
    return render(request, 'daily_lesson_count_report.html', context)
