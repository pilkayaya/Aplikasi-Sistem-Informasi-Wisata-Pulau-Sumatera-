# Generated by Django 5.0.6 on 2024-07-07 13:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wisata_app', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_pengguna',
            field=models.BooleanField(default=False),
        ),
    ]
