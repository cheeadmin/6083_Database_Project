from django.shortcuts import render, redirect, get_object_or_404
from django.db import connection
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Lesson, LessonBooking

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
        booking_date = request.POST.get('booking_date')

        with connection.cursor() as cursor:
            # Fetch customer_id based on the logged-in user. Adjust the query according to your models.
            cursor.execute("SELECT id FROM Customer WHERE user_id = %s", [user_id])
            customer_result = cursor.fetchone()

            if customer_result:
                customer_id = customer_result[0]
                # Fetch a random instructor
                cursor.execute("SELECT instructorID FROM Instructors ORDER BY RAND() LIMIT 1")
                instructor_result = cursor.fetchone()

                if instructor_result:
                    instructor_id = instructor_result[0]
                    # Make sure to use 'customer_id' and 'instructor_id' as per your schema
                    cursor.execute("""
                        INSERT INTO LessonBookings (bookingDate, customer_id, instructor_id, lesson_id) 
                        VALUES (%s, %s, %s, %s)
                    """, [booking_date, customer_id, instructor_id, lesson_id])
                    connection.commit()
                    messages.success(request, "Lesson booked successfully!")
                    return redirect('lessons_booking')
                else:
                    messages.error(request, "Instructor ID not found.")
                    return redirect('lessons_booking')
            else:
                messages.error(request, "Customer ID not found.")
                return redirect('lessons_booking')
        return redirect('lessons_booking')
    else:
        messages.error(request, "Invalid request method.")
        return redirect('lessons_booking')

@login_required
def edit_booking(request, booking_id):
    # Ensure you import LessonBookings with the correct path
    booking = get_object_or_404(LessonBookings, pk=booking_id, customer=request.user)

    # Fetch all lessons to choose from
    lessons = Lesson.objects.all().values('lessonID', 'difficultyLevel', 'duration', 'sport', 'age')
    
    if request.method == 'POST':
        new_lesson_id = request.POST.get('new_lesson')
        booking_date = request.POST.get('booking_date')  # Ensure your form has a field for booking_date

        # Perform the update with raw SQL
        with connection.cursor() as cursor:
            cursor.execute("""
                UPDATE LessonBookings 
                SET lessonID = %s, bookingDate = %s 
                WHERE bookingID = %s
            """, [new_lesson_id, booking_date, booking_id])
            connection.commit()

        messages.success(request, "Booking updated successfully.")
        return redirect('view_booked_lessons')

    context = {
        'booking': booking,
        'lessons': lessons
    }

    return render(request, 'edit_booking.html', context)

@login_required
def cancel_booking(request, booking_id):
    if request.method == 'POST':
        with connection.cursor() as cursor:
            cursor.execute("DELETE FROM LessonBookings WHERE bookingID = %s", [booking_id])
            connection.commit()
        messages.success(request, "Booking cancelled successfully.")
    else:
        messages.error(request, "You can only cancel a booking with a POST request.")
    return redirect('view_booked_lessons')

@login_required
def view_booked_lessons(request):
    user_id = request.user.id  # Use the logged-in user's ID

    try:
        with connection.cursor() as cursor:
            # Fetch customer_id based on the logged-in user
            cursor.execute("SELECT id FROM Customer WHERE user_id = %s", [user_id])
            customer_result = cursor.fetchone()
            customer_id = customer_result[0] if customer_result else None

            # Handle case where customer_id is not found
            if not customer_id:
                messages.error(request, "Customer profile not found.")
                return redirect('lessons_booking')

            # Fetch the bookings
            cursor.execute("""
                SELECT lb.bookingID, lb.bookingDate, l.sport, l.age, l.duration, l.difficultyLevel
                FROM LessonBookings lb
                INNER JOIN Lessons l ON lb.lesson_id = l.lessonID
                WHERE lb.customer_id = %s
            """, [customer_id])
            bookings = cursor.fetchall()

        bookings_list = [
            {
                'bookingID': booking[0],
                'bookingDate': booking[1].strftime('%Y-%m-%d') if booking[1] else '',
                'sport': booking[2],
                'age': booking[3],
                'duration': booking[4],
                'difficultyLevel': booking[5],
            } for booking in bookings
        ]

        context = {
            'bookings': bookings_list,
        }
        return render(request, 'view_booked_lessons.html', context)

    except OperationalError as e:
        # Log the error for debugging
        print(f"An error occurred: {e}")
        # Display a user-friendly message
        messages.error(request, "An error occurred while fetching your bookings.")
        # Redirect to a safe page
        return redirect('lessons_booking')

    except Exception as e:
        # Log the error for debugging
        print(f"An unexpected error occurred: {e}")
        # Display a user-friendly message
        messages.error(request, "An unexpected error occurred.")
        # Redirect to a safe page
        return redirect('lessons_booking')

