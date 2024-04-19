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
    path('revenue-by-equipment-type/', views.revenue_by_equipment_type, name='revenue_by_equipment_type'),
    path('most-booked-lesson-types-report/', views.most_booked_lesson_types_report, name='most_booked_lesson_types_report'),
    path('max-daily-rental-spend-details/', views.detailed_max_daily_rental_spend, name='detailed_max_daily_rental_spend'),
]


