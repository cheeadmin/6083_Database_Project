from django.urls import path
from .views import index, user_login, signup, unauthorized, create_customer_profile, home_view

urlpatterns = [
    path('', index, name='index'),
    path('login/', user_login, name='login'),
    path('signup/', signup, name='signup'),
    path('profile/', create_customer_profile, name='create_customer_profile'),
    path('home/', home_view, name='home'),  # Just use home_view here
    path('unauthorized/', unauthorized, name='unauthorized'),
    # Other paths for additional views
]
