from django.contrib import messages
from django.core.exceptions import PermissionDenied
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.db import connection, DatabaseError
from datetime import date
import datetime

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

@login_required
def daily_cancellation_report(request):
    if not request.user.is_staff:
        raise PermissionDenied

    today_date = datetime.datetime.today().strftime('%Y-%m-%d')
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT cancellationDate, COUNT(*)
                FROM LessonCancellationLog
                WHERE cancellationDate = %s
                GROUP BY cancellationDate
            """, [today_date])
            cancellation_counts = cursor.fetchall()
    except DatabaseError as e:
        messages.error(request, f"Database error: {e}")
        cancellation_counts = []

    context = {
        'date': today_date,
        'cancellation_counts': cancellation_counts,
    }
    return render(request, 'daily_cancellation_report.html', context)

@login_required
def monthly_rental_revenue_report(request):
    if not request.user.is_staff:
        messages.error(request, "Unauthorized access.")
        return redirect('home')
    
    current_month = datetime.date.today().strftime('%Y-%m')
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT Month, RentalRevenue FROM MonthlyRentalRevenue WHERE Month = %s", [current_month])
            monthly_revenue = cursor.fetchone()
    except Exception as e:
        messages.error(request, f"Database error: {e}")
        monthly_revenue = None
    
    context = {
        'monthly_revenue': monthly_revenue,
        'current_month': current_month
    }
    return render(request, 'monthly_rental_revenue_report.html', context)

@login_required
def rentals_by_sport_report(request):
    if not request.user.is_staff:
        raise PermissionDenied

    # Assuming typeID 1 is for Ski and 2 for Snowboard
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT CountRentalBySport(1)")
            ski_rentals = cursor.fetchone()[0]
            cursor.execute("SELECT CountRentalBySport(2)")
            snowboard_rentals = cursor.fetchone()[0]
    except DatabaseError as e:
        messages.error(request, f"Database error: {e}")
        ski_rentals = snowboard_rentals = 0

    context = {
        'ski_rentals': ski_rentals,
        'snowboard_rentals': snowboard_rentals,
    }
    return render(request, 'rentals_by_sport_report.html', context)
