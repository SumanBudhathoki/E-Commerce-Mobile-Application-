from django.urls import path
from .views import UserRegistration
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('login/', obtain_auth_token),
    path('register/', UserRegistration.as_view(), name= 'user_registration'),
    
]
