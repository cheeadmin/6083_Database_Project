from django.core.exceptions import PermissionDenied
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.db import connection

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
