# Generated by Django 5.0.3 on 2024-04-07 19:42

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Instructor',
            fields=[
                ('instructorID', models.AutoField(primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'Instructors',
            },
        ),
        migrations.CreateModel(
            name='Lesson',
            fields=[
                ('lessonID', models.AutoField(primary_key=True, serialize=False)),
                ('description', models.TextField(blank=True, null=True)),
                ('difficultyLevel', models.CharField(blank=True, max_length=50, null=True)),
                ('price', models.DecimalField(decimal_places=2, max_digits=10)),
            ],
            options={
                'db_table': 'Lessons',
            },
        ),
    ]