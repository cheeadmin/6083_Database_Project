# Generated by Django 5.0.3 on 2024-04-07 19:54

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chee_lessons', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Staff',
            fields=[
                ('staffID', models.AutoField(primary_key=True, serialize=False)),
                ('firstName', models.CharField(blank=True, max_length=100, null=True)),
                ('lastName', models.CharField(blank=True, max_length=100, null=True)),
                ('role', models.CharField(blank=True, max_length=100, null=True)),
                ('contactDetails', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'db_table': 'Staff',
            },
        ),
        migrations.AddField(
            model_name='instructor',
            name='staff',
            field=models.ForeignKey(db_column='staffID', null=True, on_delete=django.db.models.deletion.CASCADE, to='chee_lessons.staff'),
        ),
    ]
