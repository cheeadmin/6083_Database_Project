# Generated by Django 5.0.3 on 2024-04-09 01:50

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('chee_lessons', '0004_remove_lesson_description_lesson_age'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='LessonBooking',
            fields=[
                ('bookingID', models.AutoField(primary_key=True, serialize=False)),
                ('bookingDate', models.DateField()),
                ('customer', models.ForeignKey(db_column='customerId', on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('instructor', models.ForeignKey(db_column='instructorID', on_delete=django.db.models.deletion.CASCADE, to='chee_lessons.instructor')),
                ('lesson', models.ForeignKey(db_column='lessonID', on_delete=django.db.models.deletion.CASCADE, to='chee_lessons.lesson')),
            ],
            options={
                'db_table': 'LessonBookings',
            },
        ),
    ]
