from django.urls import path
from . import views

app_name = 'chee_equipment'

urlpatterns = [
    path('', views.list_equipment, name='list_equipment'),
    path('add/', views.add_equipment, name='add_equipment'),
    path('edit/<int:equipment_id>/', views.edit_equipment, name='edit_equipment'),
    path('delete/<int:equipment_id>/', views.delete_equipment, name='delete_equipment'),
]
