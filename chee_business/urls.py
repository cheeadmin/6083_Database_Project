from django.urls import path
from . import views

app_name = 'chee_business'

urlpatterns = [
    path('business-report/', views.business_report, name='business_report'),
    path('customer-lesson-report/', views.customer_lesson_report, name='customer_lesson_report'),
    path('daily-rental-income-report/', views.daily_rental_income_report, name='daily_rental_income_report'),
]