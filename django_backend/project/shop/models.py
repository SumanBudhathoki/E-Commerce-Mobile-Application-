from distutils.command.upload import upload
from pyexpat import model
from unicodedata import category
from django.db import models
from django.contrib.auth.models import User
from matplotlib import image
from matplotlib.pyplot import title
from numpy import true_divide
# Create your models here.


class Category (models.Model):
    title = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)
    
    def __str__(self):
        return self.title

class Product(models.Model):
    title = models.CharField(max_length=100)
    date = models.DateField(auto_now_add= True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    image = models.ImageField(upload_to = "products/")
    market_price = models.PositiveIntegerField()
    selling_price = models.PositiveIntegerField()
    description = models.TextField()

    def __str__(self):
        return self.title


class Favourite(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    isFavorite = models.BooleanField(default=False)

    def __str__(self):
        return f"productID = {self.product.id} user = {self.user.username}| IsFavourite = {self.isFavorite}"

class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
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
        return f"Cart == {self.cart.id}<==>CartProduct:{self.id} == Quality == {self.quantity}"

class Order(models.Model):
    cart = models.OneToOneField(Cart, on_delete=models.CASCADE)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=13)
    address = models.CharField(max_length=100)




    


    



