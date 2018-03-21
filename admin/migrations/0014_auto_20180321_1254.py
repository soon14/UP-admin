# Generated by Django 2.0.3 on 2018-03-21 11:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('admin', '0013_group_course'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='attendance',
            options={'ordering': ['client__surname']},
        ),
        migrations.AddField(
            model_name='attendancestate',
            name='visible',
            field=models.BooleanField(default=True),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='course',
            name='visible',
            field=models.BooleanField(default=True),
            preserve_default=False,
        ),
    ]
