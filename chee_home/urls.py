from django.urls import path
from django.contrib.auth import views as auth_views
from django.views.generic.base import RedirectView
from django.contrib.auth.views import LogoutView
from .views import (
    index, user_login, signup, unauthorized, create_customer_profile, home_view,
    read_customer_profiles, update_customer_profile, delete_customer_profile, user_view, 
    register_staff, list_staff, edit_staff, delete_staff, add_staff
)

urlpatterns = [
    path('', index, name='index'),
    path('login/', user_login, name='login'),
    path('signup/', signup, name='signup'),
    path('profile/', create_customer_profile, name='create_customer_profile'),
    path('home/', home_view, name='home'),
    path('unauthorized/', unauthorized, name='unauthorized'),
    path('profile/read/', read_customer_profiles, name='read_customer_profiles'),
    path('profile/update/<int:profile_id>/', update_customer_profile, name='update_customer_profile'),
    path('profile/delete/<int:profile_id>/', delete_customer_profile, name='delete_customer_profile'),
    path('user/', user_view, name='user'),
    path('register-staff/', register_staff, name='register_staff'),
    path('staff-maintenance/add/', add_staff, name='add_staff'),
    path('staff-maintenance/', list_staff, name='list_staff'),
    path('staff-maintenance/edit/<int:staff_id>/', edit_staff, name='edit_staff'),
    path('staff-maintenance/delete/<int:staff_id>/', delete_staff, name='delete_staff'),
    path('logout/', auth_views.LogoutView.as_view(next_page='index'), name='logout'),
]
