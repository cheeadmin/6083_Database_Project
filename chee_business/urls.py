from django.urls import path
from . import views

app_name = 'chee_business'

urlpatterns = [
    path('business-report/', views.business_report, name='business_report'),
    path('customer-lesson-report/', views.customer_lesson_report, name='customer_lesson_report'),
    path('daily-rental-income-report/', views.daily_rental_income_report, name='daily_rental_income_report'),
    path('daily-lesson-count-report/', views.daily_lesson_count_report, name='daily_lesson_count_report'),
    path('daily-cancellation-report/', views.daily_cancellation_report, name='daily_cancellation_report'),
    path('monthly-revenue-report/', views.monthly_rental_revenue_report, name='monthly_rental_revenue_report'),
    path('rentals-by-sport-report/', views.rentals_by_sport_report, name='rentals_by_sport_report'),

]
