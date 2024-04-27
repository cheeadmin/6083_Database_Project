from django.shortcuts import render, redirect, get_object_or_404
from django.db import connection, OperationalError,  IntegrityError, DataError, transaction
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Lesson, LessonBooking
from django.http import Http404, HttpResponse
from django.core.exceptions import PermissionDenied
from chee_home.models import Customer
from .models import Instructor

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
        booking_date = request.POST.get('booking_date')

        try:
            customer = Customer.objects.get(user=request.user)
        except Customer.DoesNotExist:
            messages.error(request, "No customer profile found for this user.")
            return redirect('lessons_booking')

        try:
            with transaction.atomic():
                cursor = connection.cursor()

                # Fetch a random instructor
                cursor.execute("SELECT instructorID FROM Instructors ORDER BY RAND() LIMIT 1")
                instructor_result = cursor.fetchone()

                if instructor_result:
                    instructor_id = instructor_result[0]
                    # Insert into LessonBookings
                    cursor.execute("""
                        INSERT INTO LessonBookings (bookingDate, customer_id, instructor_id, lesson_id) 
                        VALUES (%s, %s, %s, %s)
                    """, [booking_date, customer.id, instructor_id, lesson_id])
                    messages.success(request, "Lesson booked successfully!")
                else:
                    messages.error(request, "Instructor not found.")
        except Exception as e:
            messages.error(request, f"An error occurred: {e}")

        return redirect('lessons_booking')


@login_required
def edit_booking(request, booking_id):
    # Get all lessons to populate the select field
    with connection.cursor() as cursor:
        cursor.execute("SELECT lessonID, difficultyLevel, duration, sport, age FROM Lessons")
        lessons = cursor.fetchall()
        lessons_list = [
            {
                'lessonID': lesson[0],
                'difficultyLevel': lesson[1],
                'duration': lesson[2],
                'sport': lesson[3],
                'age': lesson[4],
            }
            for lesson in lessons
        ]

    # If the form has been submitted, process the form data
    if request.method == 'POST':
        new_lesson_id = request.POST.get('new_lesson')
        booking_date = request.POST.get('booking_date')
        
        # Update the booking in the database
        try:
            with transaction.atomic():
                cursor = connection.cursor()
                cursor.execute("""
                    UPDATE LessonBookings
                    SET lesson_id = %s, bookingDate = %s
                    WHERE bookingID = %s
                """, [new_lesson_id, booking_date, booking_id])
            
            messages.success(request, "Booking updated successfully.")
        except Exception as e:
            messages.error(request, f"An error occurred while updating the booking: {e}")
        
        return redirect('view_booked_lessons')
    
    # If it's a GET request, we fetch the booking info to prefill the form
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT bookingID, bookingDate, lesson_id FROM LessonBookings WHERE bookingID = %s", [booking_id])
            booking = cursor.fetchone()
            if not booking:
                raise Http404("Booking not found.")

        # Prepare the booking info for the context
        booking_info = {
            'bookingID': booking[0],
            'bookingDate': booking[1].strftime('%Y-%m-%d') if booking[1] else '',
            'lessonID': booking[2],
        }
        
        # Render the edit page
        return render(request, 'edit_booking.html', {
            'booking': booking_info,
            'lessons': lessons_list,
        })
    
    except Exception as e:
        messages.error(request, f"An error occurred: {e}")
        return redirect('view_booked_lessons')

@login_required
def view_booked_lessons(request):
    # Get the customer_id from the Customer model
    try:
        customer = Customer.objects.get(user=request.user)
    except Customer.DoesNotExist:
        messages.error(request, "Customer profile not found.")
        return redirect('lessons_booking')

    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT lb.bookingID, lb.bookingDate, l.sport, l.age, l.duration, l.difficultyLevel
                FROM LessonBookings lb
                INNER JOIN Lessons l ON lb.lesson_id = l.lessonID
                WHERE lb.customer_id = %s
            """, [customer.id])
            bookings = cursor.fetchall()

        bookings_list = [{
            'bookingID': booking[0],
            'bookingDate': booking[1].strftime('%Y-%m-%d') if booking[1] else '',
            'sport': booking[2],
            'age': booking[3],
            'duration': booking[4],
            'difficultyLevel': booking[5],
        } for booking in bookings]

        return render(request, 'view_booked_lessons.html', {'bookings': bookings_list})
    except OperationalError as e:
        messages.error(request, f"An error occurred while fetching your bookings: {e}")
        return redirect('lessons_booking')
    except Exception as e:
        messages.error(request, f"An unexpected error occurred: {e}")
        return redirect('lessons_booking')

@login_required
def cancel_booking(request, booking_id):
    if request.method == 'POST':
        try:
            with transaction.atomic():
                cursor = connection.cursor()
                cursor.execute("DELETE FROM LessonBookings WHERE bookingID = %s", [booking_id])
            
            messages.success(request, "Booking cancelled successfully.")
        except Exception as e:
            messages.error(request, f"Error cancelling booking: {e}")

        return redirect('view_booked_lessons')
    else:
        messages.error(request, "You can only cancel a booking with a POST request.")
        return redirect('view_booked_lessons')

@login_required
def list_lessons(request):
    if not request.user.is_staff:
        raise PermissionDenied

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Lessons")
        lessons_tuples = cursor.fetchall()
        lessons = [
            {'lessonID': lesson[0], 'difficultyLevel': lesson[1], 'duration': lesson[2], 'sport': lesson[3], 'age': lesson[4]}
            for lesson in lessons_tuples
        ]

    return render(request, 'list_lessons.html', {'lessons': lessons})

@login_required
def add_lesson(request):
    if not request.user.is_staff:
        raise PermissionDenied

    if request.method == 'POST':
        difficultyLevel = request.POST['difficultyLevel']
        duration = request.POST['duration']
        sport = request.POST['sport']
        age = request.POST['age']

        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    cursor.execute("""
                        INSERT INTO Lessons (difficultyLevel, duration, sport, age)
                        VALUES (%s, %s, %s, %s)
                    """, [difficultyLevel, duration, sport, age])
                messages.success(request, 'Lesson added successfully!')
        except Exception as e:
            messages.error(request, f'Error adding lesson: {str(e)}')

        return redirect('list_lessons')

    return render(request, 'add_lesson.html')

@login_required
def edit_lesson(request, lesson_id):
    if not request.user.is_staff:
        messages.error(request, "Unauthorized access.")
        return redirect('home')

    lesson_dict = {}
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM Lessons WHERE lessonID = %s", [lesson_id])
            lesson = cursor.fetchone()
            if lesson:
                lesson_dict = {
                    'lessonID': lesson[0],
                    'difficultyLevel': lesson[1],
                    'duration': lesson[2],
                    'sport': lesson[3],
                    'age': lesson[4]
                }
            else:
                raise Http404("Lesson not found.")
    except Exception as e:
        messages.error(request, str(e))
        return redirect('lesson_management')

    if request.method == 'POST':
        difficultyLevel = request.POST.get('difficultyLevel')
        duration = request.POST.get('duration')
        sport = request.POST.get('sport')
        age = request.POST.get('age')

        if len(duration) > 8 or len(age) > 5:
            messages.error(request, "Duration or Age values are too long.")
            return render(request, 'edit_lesson.html', {'lesson': lesson_dict})

        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    cursor.execute("""
                        UPDATE Lessons SET
                        difficultyLevel = %s,
                        duration = %s,
                        sport = %s,
                        age = %s
                        WHERE lessonID = %s
                    """, [difficultyLevel, duration, sport, age, lesson_id])
            messages.success(request, "Lesson updated successfully!")
        except Exception as e:
            messages.error(request, "An error occurred: " + str(e))

        return redirect('lesson_management')

    return render(request, 'edit_lesson.html', {'lesson': lesson_dict})

@login_required
def delete_lesson(request, lesson_id):
    if not request.user.is_staff:
        raise PermissionDenied

    if request.method == 'POST':
        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    cursor.execute("DELETE FROM Lessons WHERE lessonID = %s", [lesson_id])
                messages.success(request, 'Lesson deleted successfully!')
        except Exception as e:
            messages.error(request, f'Error deleting lesson: {e}')
        
        return redirect('list_lessons')

    messages.error(request, 'Invalid request method.')
    return redirect('list_lessons')

@login_required
def lesson_management(request):
    if not request.user.is_staff:
        # Only staff can manage lessons
        return redirect('unauthorized')
    
    # You can fetch lessons or perform other logic here
    lessons = Lesson.objects.all()  # Assuming you have a Lesson model
    return render(request, 'list_lessons.html', {'lessons': lessons})