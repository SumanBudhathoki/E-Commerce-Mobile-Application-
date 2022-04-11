from tkinter import CASCADE
from django.db import models
# from django.contrib.auth import get_user_model
from django.contrib.auth.models import AbstractUser

# User = get_user_model()
# Create your models here.
class CustomUser(AbstractUser):
    is_seller = models.BooleanField('Is Wholesaler', default=False)
    is_customer = models.BooleanField('Is Retailer', default=True)


class Retailer(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    address = models.CharField(max_length=200)

    def __str__(self):
        return self.user

class Wholesaler(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    shop_name = models.CharField(max_length=200)
    address = models.CharField(max_length=200)

    def __str__(self):
        return self.user


class Category (models.Model):
    title = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)
    
    def __str__(self):
        return self.title

class Product(models.Model):
    title = models.CharField(max_length=100)
    date = models.DateField(auto_now_add= True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    image = models.ImageField(upload_to = "products/",blank=True, null=True )
    selling_price = models.PositiveIntegerField()
    description = models.TextField()

    def __str__(self):
        return self.title


class Favourite(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    isFavorite = models.BooleanField(default=False)

    def __str__(self):
        return f"productID = {self.product.id} user = {self.user.username}| IsFavourite = {self.isFavorite}"

class Cart(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    total = models.PositiveIntegerField()
    isComplete = models.BooleanField(default=False)
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"User = {self.user.username}| isComplete = {self.isComplete} "

class CartProduct(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product = models.ManyToManyField(Product)
    price = models.PositiveIntegerField()
    quantity = models.PositiveIntegerField()
    subtotal = models.PositiveIntegerField()

    def __str__(self):
        return f"Cart == {self.cart.id}<==>CartProduct:{self.id} == Quantity == {self.quantity}"

class Order(models.Model):
    cart = models.OneToOneField(Cart, on_delete=models.CASCADE)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=13)
    address = models.CharField(max_length=100)




    


    



