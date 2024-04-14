from django.core.exceptions import PermissionDenied
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.db import connection
from .models import Equipment

@login_required
def list_equipment(request):
    if not request.user.is_staff:
        raise PermissionDenied

    with connection.cursor() as cursor:
        cursor.execute("SELECT equipmentID, Brand, Description, typeID, Availability, LastMaintenance, Price, Size FROM Equipment")
        equipments = cursor.fetchall()

    equipments_list = [
        {
            'equipmentID': eq[0],
            'Brand': eq[1],
            'Description': eq[2],
            'typeID': eq[3],
            'Availability': eq[4],
            'LastMaintenance': eq[5].strftime('%Y-%m-%d') if eq[5] else None,
            'Price': eq[6],
            'Size': eq[7]
        }
        for eq in equipments
    ]

    return render(request, 'list_equipment.html', {'equipments': equipments_list})

@login_required
def add_equipment(request):
    if request.method == 'POST':
        brand = request.POST.get('brand')
        description = request.POST.get('description')
        typeID = request.POST.get('typeID')
        availability = request.POST.get('availability')
        lastMaintenance = request.POST.get('lastMaintenance')
        price = request.POST.get('price')
        size = request.POST.get('size')

        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO Equipment (Brand, Description, typeID, Availability, LastMaintenance, Price, Size) VALUES (%s, %s, %s, %s, %s, %s, %s)", [brand, description, typeID, availability, lastMaintenance, price, size])
        return redirect('chee_equipment:list_equipment')
    return render(request, 'chee_equipment/add_equipment.html')

@login_required
def edit_equipment(request, equipment_id):
    equipment = get_object_or_404(Equipment, pk=equipment_id)
    if request.method == 'POST':
        equipment.brand = request.POST.get('brand')
        equipment.description = request.POST.get('description')
        equipment.typeID = request.POST.get('typeID')
        equipment.availability = request.POST.get('availability')
        equipment.lastMaintenance = request.POST.get('lastMaintenance')
        equipment.price = request.POST.get('price')
        equipment.size = request.POST.get('size')
        equipment.save()
        return redirect('chee_equipment:list_equipment')
    return render(request, 'chee_equipment/edit_equipment.html', {'equipment': equipment})

@login_required
def delete_equipment(request, equipment_id):
    equipment = get_object_or_404(Equipment, pk=equipment_id)
    equipment.delete()
    return redirect('chee_equipment:list_equipment')
