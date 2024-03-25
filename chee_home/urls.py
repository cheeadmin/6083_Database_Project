from django.urls import path
from .views import index, user_login, signup, unauthorized

urlpatterns = [
    path('', index, name='index'),
    path('login/', user_login, name='login'),
    path('signup/', signup, name='signup'),
    path('unauthorized/', unauthorized, name='unauthorized'),
    # Other paths for additional views
]