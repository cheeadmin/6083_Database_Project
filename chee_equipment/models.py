from django.db import models

class Equipment(models.Model):
    equipmentID = models.AutoField(primary_key=True)
    brand = models.CharField(max_length=100)
    description = models.TextField()
    typeID = models.IntegerField()
    availability = models.BooleanField(default=True)
    lastMaintenance = models.DateField()
    price = models.DecimalField(max_digits=6, decimal_places=2)
    size = models.IntegerField()

    def __str__(self):
        return f"{self.brand} - {self.description}"
