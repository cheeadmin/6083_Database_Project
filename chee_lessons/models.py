from django.conf import settings
from django.db import models

class Staff(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='staff_profile',
        null=True  # Assuming not all users are staff
    )
    staffID = models.AutoField(primary_key=True)
    firstName = models.CharField(max_length=100, blank=True, null=True)
    lastName = models.CharField(max_length=100, blank=True, null=True)
    role = models.CharField(max_length=100, blank=True, null=True)
    contactDetails = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = 'Staff'

class Instructor(models.Model):
    instructorID = models.AutoField(primary_key=True)
    staff = models.ForeignKey(Staff, null=True, on_delete=models.CASCADE, db_column='staffID')

    class Meta:
        db_table = 'Instructors'

class Lesson(models.Model):
    lessonID = models.AutoField(primary_key=True)
    difficultyLevel = models.CharField(max_length=50, blank=True, null=True)
    sport = models.CharField(max_length=10, choices=(('Ski', 'Ski'), ('Snowboard', 'Snowboard')), null=True)
    duration = models.CharField(max_length=8, choices=(('Half Day', 'Half Day'), ('Full Day', 'Full Day')), null=True)
    age = models.CharField(max_length=5, choices=(('Adult', 'Adult'), ('Kid', 'Kid')), null=True)

    class Meta:
        db_table = 'Lessons'

class LessonBooking(models.Model):  # Ensure that the class name matches your import
    bookingID = models.AutoField(primary_key=True)
    bookingDate = models.DateField()
    customer = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    instructor = models.ForeignKey('Instructor', on_delete=models.CASCADE)
    lesson = models.ForeignKey('Lesson', on_delete=models.CASCADE)

    class Meta:
        db_table = 'LessonBookings'