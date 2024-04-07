from django.db import models

class Staff(models.Model):
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