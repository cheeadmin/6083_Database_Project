from django.db import models
from chee_home.models import Customer 

class EquipmentType(models.Model):
    typeID = models.AutoField(primary_key=True)
    # ... Other fields ...

class Equipment(models.Model):
    equipmentID = models.AutoField(primary_key=True)
    Brand = models.CharField(max_length=45, blank=True, null=True)
    Condition = models.CharField(max_length=45, blank=True, null=True)
    typeID = models.ForeignKey(EquipmentType, on_delete=models.SET_NULL, null=True)

    class Meta:
        ordering = ['Brand']  # Assuming you might want to order by brand or any other attribute.

class Rental(models.Model):
    rentalID = models.AutoField(primary_key=True)
    rentalDate = models.DateField()
    returnDate = models.DateField()
    Price = models.DecimalField(max_digits=10, decimal_places=2)
    equipmentID = models.ForeignKey(Equipment, on_delete=models.SET_NULL, null=True)
    customerId = models.ForeignKey(Customer, on_delete=models.SET_NULL, null=True)

    class Meta:
        ordering = ['-rentalDate']  # Rentals are often ordered by date.

# Be sure to run migrations after adding or changing models
