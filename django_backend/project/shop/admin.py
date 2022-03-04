from attr import Factory
from django.contrib import admin
from .models import *

admin.site.register([Cart, Product, CartProduct, Category, Order, Favourite, ])
# Register your models here.
