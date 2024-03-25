from django.db import models

class Customer(models.Model):
    customerId = models.IntegerField(primary_key=True)
    firstName = models.CharField(max_length=100, null=True)
    lastName = models.CharField(max_length=100, null=True)
    contactInfo = models.CharField(max_length=255, null=True)
    PaymentDetails = models.CharField(max_length=255, null=True)

    class Meta:
        db_table = 'Customer'