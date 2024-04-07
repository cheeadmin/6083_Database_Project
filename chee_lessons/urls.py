from django.urls import path
from .views import lessons_booking, book_lesson

urlpatterns = [
    path('lessons-booking/', lessons_booking, name='lessons_booking'),
    path('book-lesson/', book_lesson, name='book_lesson'),
]