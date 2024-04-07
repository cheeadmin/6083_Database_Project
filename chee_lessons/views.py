from django.shortcuts import render, redirect
from django.db import connection
from django.contrib.auth.decorators import login_required
from django.contrib import messages

def lessons_booking(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT lessonID, difficultyLevel, duration, sport, age FROM Lessons")
        lessons = cursor.fetchall()
    
    # Convert the list of tuples from the raw SQL query to a list of dictionaries for the template to use
    lessons_list = [
        {
            'lessonID': lesson[0],
            'difficultyLevel': lesson[1],
            'duration': lesson[2],
            'sport': lesson[3],
            'age': lesson[4],
        } for lesson in lessons
    ]

    context = {
        'lessons': lessons_list,
    }
    return render(request, 'lessons_booking.html', context)

@login_required
def book_lesson(request, lesson_id):
    if request.method == 'POST':
        user_id = request.user.id
        booking_date = request.POST.get('bookingDate')

        with connection.cursor() as cursor:
            # Fetch customer_id based on the logged-in user. Adjust the query according to your models.
            cursor.execute("SELECT id FROM Customer WHERE user_id = %s", [user_id])
            customer_id = cursor.fetchone()[0]

            # Selecting a random instructor from the Instructors table.
            cursor.execute("SELECT instructorID FROM Instructors ORDER BY RAND() LIMIT 1")
            instructor_id = cursor.fetchone()[0]

            # Insert booking details into LessonBookings table
            cursor.execute(
                "INSERT INTO LessonBookings (bookingDate, customerId, instructorID, lessonID) VALUES (%s, %s, %s, %s)",
                [booking_date, customer_id, instructor_id, lesson_id]
            )
            connection.commit()

        messages.success(request, "Lesson booked successfully!")
        return redirect('lessons_booking')  # Make sure 'lessons_booking' is your correct redirect URL name
    else:
        # Redirect back to the booking page or show an error if accessed without POST request
        messages.error(request, "Invalid request method.")
        return redirect('lessons_booking')
