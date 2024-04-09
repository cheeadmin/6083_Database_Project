from django.urls import path
from .views import lessons_booking, book_lesson, view_booked_lessons, edit_booking, cancel_booking

urlpatterns = [
    path('lessons-booking/', lessons_booking, name='lessons_booking'),
    path('book-lesson/<int:lesson_id>/', book_lesson, name='book_lesson'),
    path('view-booked-lessons/', view_booked_lessons, name='view_booked_lessons'),
    path('edit-booking/<int:booking_id>/', edit_booking, name='edit_booking'),
    path('cancel-booking/<int:booking_id>/', cancel_booking, name='cancel_booking'),
]