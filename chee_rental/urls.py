from django.urls import include, path
from . import views
from .views import rent_equipment

urlpatterns = [
    path('', views.equipment_list, name='equipment_list'),  # Change this line
    path('add/<int:equipment_id>/', views.add_to_rental_cart, name='add_to_rental_cart'),
    path('rental/skis/', views.list_skis, name='rent_ski'),
    path('rental/snowboards/', views.list_snowboards, name='rent_snowboard'),
    path('rental/rent/<int:equipment_id>/', views.rent_equipment, name='rent_equipment'),
    path('rental/return/<int:equipment_id>/', views.return_equipment, name='return_equipment'),
]