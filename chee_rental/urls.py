from django.urls import path
from . import views

urlpatterns = [
    path('', views.equipment_list, name='equipment_list'),  # Change this line
    path('add/<int:equipment_id>/', views.add_to_rental_cart, name='add_to_rental_cart'),
]