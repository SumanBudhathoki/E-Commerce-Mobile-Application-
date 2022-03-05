from unicodedata import name
from django.urls import path
from .views import *
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('login/', obtain_auth_token),
    path('register/', UserRegistration.as_view(), name= 'user_registration'),
    path('products/', ProductView.as_view(),name= 'product_view'),
    path('favourite/',FavouriteView.as_view(), name = 'favourite_view')

]
