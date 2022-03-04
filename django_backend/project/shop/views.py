from cgi import print_directory
from math import prod
from .serializers import * #serializers that we created 
from rest_framework.views import APIView #Class based views
from rest_framework.response import Response #For response
from rest_framework import status #Status code for imformative response
from django.contrib.auth.models import User
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication


class UserRegistration(APIView):
    #To access the list of all registered users

    # def get(self, format= None):
    #     users = User.objects.all()
    #     serializer = UserSerializer(users,  many = True)
    #     return Response(serializer.data)

    # To create the user
    def post(self, request):

        
        serializer = UserSerializer(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error" : True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )

class ProductView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication,]
    def get(self, request):
        query = Product.objects.all()
        data = []
        serializers = ProductSerializer(query, many = True)
        for product in serializers.data:
            fav_query = Favourite.objects.filter(user = request.user).filter(
                product_id = product['id']
            )
            if fav_query:
                product['favourite'] = fav_query[0].isFavorite
            else:
                product['favourite'] = False
            data.append(product)
        return Response(data)
