# database.py
from django.db import connection

def create_customer(user_id, firstName, lastName, contactInfo, paymentDetails):
    with connection.cursor() as cursor:
        cursor.execute("""
            INSERT INTO Customer (user_id, firstName, lastName, contactInfo, PaymentDetails)
            VALUES (%s, %s, %s, %s, %s)
        """, [user_id, firstName, lastName, contactInfo, paymentDetails])

def get_customer_by_id(customer_id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Customer WHERE customerId = %s", [customer_id])
        return cursor.fetchone()