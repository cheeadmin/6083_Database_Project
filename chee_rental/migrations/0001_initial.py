# Generated by Django 5.0.3 on 2024-03-31 23:48

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('chee_home', '0002_alter_customer_user'),
    ]

    operations = [
        migrations.CreateModel(
            name='EquipmentType',
            fields=[
                ('typeID', models.AutoField(primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='Equipment',
            fields=[
                ('equipmentID', models.AutoField(primary_key=True, serialize=False)),
                ('Brand', models.CharField(blank=True, max_length=45, null=True)),
                ('Condition', models.CharField(blank=True, max_length=45, null=True)),
                ('typeID', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='chee_rental.equipmenttype')),
            ],
            options={
                'ordering': ['Brand'],
            },
        ),
        migrations.CreateModel(
            name='Rental',
            fields=[
                ('rentalID', models.AutoField(primary_key=True, serialize=False)),
                ('rentalDate', models.DateField()),
                ('returnDate', models.DateField()),
                ('Price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('customerId', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='chee_home.customer')),
                ('equipmentID', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='chee_rental.equipment')),
            ],
            options={
                'ordering': ['-rentalDate'],
            },
        ),
    ]
