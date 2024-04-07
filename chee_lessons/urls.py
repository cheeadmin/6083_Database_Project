from django.urls import path
from .views import lessons_booking, book_lesson

urlpatterns = [
    path('lessons-booking/', lessons_booking, name='lessons_booking'),
    path('book-lesson/<int:lesson_id>/', book_lesson, name='book_lesson'),
]