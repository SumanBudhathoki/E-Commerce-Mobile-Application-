from attr import Factory
from django.contrib import admin
from .models import *
# Register your models here.
admin.site.register([TestImageUpload,CustomUser,Retailer, Wholesaler, Cart, Product, CartProduct, Category, Order, Favourite, ])

