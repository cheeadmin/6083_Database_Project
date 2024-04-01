from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('chee_home.urls')), 
    path('rental/', include('chee_rental.urls')),
]
