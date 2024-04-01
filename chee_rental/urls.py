from django.urls import path
from . import views

urlpatterns = [
    path('', views.equipment_list, name='equipment_list'),  # Change this line
    path('add/<int:equipment_id>/', views.add_to_rental_cart, name='add_to_rental_cart'),
    path('rental/skis/', views.list_skis, name='rent_ski'),
    path('rental/snowboards/', views.list_snowboards, name='rent_snowboard'),
]