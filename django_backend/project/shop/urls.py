from unicodedata import name
from django.urls import path
from .views import *
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('login/', obtain_auth_token),
    path('register/', UserRegistration.as_view(), name= 'user_registration'),
    path('register/seller/', UserRegistrationSeller.as_view(), name= 'user_registration_seller'),
    path('products/', ProductView.as_view(),name= 'product_view'),
    path('product_search/', ProductSearchView.as_view(),name= 'product_view_search'),
    path('category/', CategoryView.as_view(),name= 'category_view'),
    path('favourite/',FavouriteView.as_view(), name = 'favourite_view'),
    path('cart/',CartView.as_view(), name = 'cart_view'),
    path('order/',OrderView.as_view(), name = 'order_view'),
    path('ordernow/',OrderCreateView.as_view(), name = 'order_create'),
    path('addtocart/',AddToCart.as_view(), name = 'addtocart_view'),
    path('deletecartproduct/',DeleteCartProduct.as_view(), name = 'delete_cart_product'),
    path('deleteallcart/', DeleteAllCart.as_view(), name= 'delete_all_cart'),

]
