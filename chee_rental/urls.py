from django.urls import path
from . import views
from .views import equipment_list, add_to_cart, show_cart, remove_from_cart, list_skis, list_snowboards, rent_equipment, return_equipment, finalize_rental, list_rented, return_rental

urlpatterns = [
    path('', views.equipment_list, name='equipment_list'),
    path('add-to-cart/<int:equipment_id>/', views.add_to_rental_cart, name='add_to_rental_cart'),
    path('rental/snowboards/', views.list_snowboards, name='list_snowboards'),
    path('rental/skis/', views.list_skis, name='list_skis'),
    path('rent/<int:equipment_id>/', views.rent_equipment, name='rent_equipment'),
    path('rental/error/', views.rental_error, name='rental_error'),
    path('rental/return/<int:equipment_id>/', views.return_equipment, name='return_equipment'),
    path('rental/cart/', views.show_cart, name='rental_cart'),
    path('rental/cart/', show_cart, name='show_cart'),
    path('rental/cart/add/<int:equipment_id>/', views.add_to_cart, name='add_to_cart'),
    path('rental/cart/remove/<int:equipment_id>/', views.remove_from_cart, name='remove_from_cart'),
    path('rental/cart/finalize/', views.finalize_rental, name='finalize_rental'),
    path('rented/', list_rented, name='list_rented'),
    path('return/<int:rental_id>/', return_rental, name='return_rental'),
    path('rented/snowboards/', views.list_rented_snowboards, name='list_rented_snowboards'),
    path('return/snowboard/<int:rental_id>/', views.return_snowboard_rental, name='return_snowboard_rental'),
    path('rental/<int:rental_id>/edit-return-date/', views.edit_return_date, name='edit_return_date'),
]
