from django.db import models

class Equipment(models.Model):
    equipmentID = models.AutoField(primary_key=True)
    brand = models.CharField(max_length=45, blank=True, null=True)  # Allowing null and blank for consistency with the schema
    description = models.CharField(max_length=255, blank=True, null=True)
    typeID = models.IntegerField(null=True)  # Nullable as indicated by YES under Null column in the schema
    availability = models.BooleanField(default=True)
    lastMaintenance = models.DateField(null=True, blank=True)  # Nullable date
    price = models.DecimalField(max_digits=10, decimal_places=2)  # Adjust max_digits to match the schema
    size = models.CharField(max_length=45, blank=True, null=True)  # Changed from IntegerField to CharField to match your schema

    def __str__(self):
        return f"{self.brand} - {self.description}"
