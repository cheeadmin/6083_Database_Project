from django.urls import path
from . import views

app_name = 'chee_equipment'

urlpatterns = [
    path('', views.list_equipment, name='list_equipment'),
    path('add/', views.add_equipment, name='add_equipment'),
    path('edit/<int:equipment_id>/', views.edit_equipment, name='edit_equipment'),
    path('delete/<int:equipment_id>/', views.delete_equipment, name='delete_equipment'),
    path('maintenance/', views.list_maintenance_equipments, name='list_maintenance_equipments'),
    path('maintenance/add/<int:equipment_id>/', views.add_equipment_to_maintenance, name='add_to_maintenance'),
    path('maintenance/delete/<int:maintenance_id>/', views.delete_equipment_from_maintenance, name='delete_from_maintenance'),
]
