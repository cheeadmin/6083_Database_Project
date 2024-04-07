from django.shortcuts import render, redirect
from django.db import connection
from django.contrib.auth.decorators import login_required
from django.contrib import messages

def lessons_booking(request):
    # Example: Fetch lessons from the database using raw SQL query
    # Assuming 'connection' from 'django.db' is used for executing raw SQL queries
    from django.db import connection
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Lessons")
        lessons = cursor.fetchall()

    context = {
        'lessons': lessons,
    }
    return render(request, 'lessons_booking.html', context)

@login_required
def book_lesson(request, lesson_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            # Replace '7' with the id retrieved from the request.user
            customer_id = 7
            instructor_id = 1  # For now, let's assume instructor ID 1
            booking_date = request.POST['bookingDate']
            cursor.execute(
                "INSERT INTO LessonBookings (bookingDate, customerId, instructorID, lessonID) VALUES (%s, %s, %s, %s)",
                [booking_date, customer_id, instructor_id, lesson_id]
            )
            connection.commit()
        messages.success(request, "Lesson booked successfully!")
        return redirect('list_lessons')
    else:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM Lessons WHERE lessonID = %s", [lesson_id])
            lesson = cursor.fetchone()
        return render(request, 'book_lesson.html', {'lesson': lesson})