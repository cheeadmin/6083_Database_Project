from django.urls import path
from .views import lessons_booking, book_lesson, view_booked_lessons, edit_booking, cancel_booking, list_lessons, add_lesson, edit_lesson, delete_lesson, lesson_management

urlpatterns = [
    path('lessons-booking/', lessons_booking, name='lessons_booking'),
    path('book-lesson/<int:lesson_id>/', book_lesson, name='book_lesson'),
    path('view-booked-lessons/', view_booked_lessons, name='view_booked_lessons'),
    path('edit-booking/<int:booking_id>/', edit_booking, name='edit_booking'),
    path('cancel-booking/<int:booking_id>/', cancel_booking, name='cancel_booking'),
    path('lessons/', list_lessons, name='list_lessons'),
    path('lessons/add/', add_lesson, name='add_lesson'),
    path('lessons/edit/<int:lesson_id>/', edit_lesson, name='edit_lesson'),
    path('lessons/delete/<int:lesson_id>/', delete_lesson, name='delete_lesson'),
    path('lesson-management/', lesson_management, name='lesson_management'),
]