from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('chee_home.urls')),  # Include the URLs of the home app
    # Other URL patterns for additional apps
]
