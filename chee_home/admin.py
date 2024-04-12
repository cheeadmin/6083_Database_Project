from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from chee_lessons.models import Staff  # Correct import path
from .models import Customer

class StaffInline(admin.StackedInline):
    model = Staff
    can_delete = False
    verbose_name_plural = 'staff'
    extra = 0  # Controls the number of extra forms displayed.

class CustomUserAdmin(UserAdmin):
    inlines = (StaffInline,)

    def get_inline_instances(self, request, obj=None):
        if not obj:
            return []
        return super(CustomUserAdmin, self).get_inline_instances(request, obj)

# Unregister the original User admin to replace it with CustomUserAdmin
admin.site.unregister(User)
admin.site.register(User, CustomUserAdmin)
admin.site.register(Customer)
