from django.db import models
from django.conf import settings

class Customer(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    firstName = models.CharField(max_length=100, null=True)
    lastName = models.CharField(max_length=100, null=True)
    contactInfo = models.CharField(max_length=255, null=True)
    paymentDetails = models.CharField(max_length=255, null=True)

    class Meta:
        db_table = 'Customer'