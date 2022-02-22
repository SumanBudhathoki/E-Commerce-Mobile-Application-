from django.contrib.auth.models import User #To use the default user model by django
from rest_framework import serializers #To create a serializer class
from rest_framework.validators import UniqueTogetherValidator #Validators in restframework
from rest_framework.authtoken.models import Token
class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User #Model that we are creating serializer of 
        #Fields for our user
        fields = (
            'username', 'first_name', 'last_name', 'email', 'password',
        )
        
        #Create function
        def create(self, validated_data):
            user = User.objects.create_user(**validated_data)
            Token.objects.create(user = user)
            return user
            
        #validation 
        #UniqueTogetherValidator will allow us to varify the username and the email
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields= ['username', 'email']
            )
        ]

