from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from chee_lessons.models import Staff
from .models import Customer

# Define an inline admin descriptor for Staff model
# which acts a bit like a singleton
class StaffInline(admin.StackedInline):
    model = Staff
    can_delete = False
    verbose_name_plural = 'staff'
    fk_name = 'user'

# Define a new User admin
class CustomUserAdmin(UserAdmin):
    inlines = (StaffInline, )
    list_display = ('username', 'email', 'first_name', 'last_name', 'is_staff')

    def get_inline_instances(self, request, obj=None):
        if not obj:
            return list()
        return super(CustomUserAdmin, self).get_inline_instances(request, obj)

# Re-register UserAdmin
admin.site.unregister(User)
admin.site.register(User, CustomUserAdmin)
admin.site.register(Customer)
