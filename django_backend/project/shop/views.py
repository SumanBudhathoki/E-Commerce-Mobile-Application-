from .serializers import UserSerializer #serializer that we created 
from rest_framework.views import APIView #Class based views
from rest_framework.response import Response #For response
from rest_framework import status #Status code for imformative response
# from rest_framework.permissions import IsAdminUser #for checking the user is staff or not
from django.contrib.auth.models import User


class UserRegistration(APIView):
    # permission_classes = [IsAdminUser]

    #To access the list of all registered users

    def get(self, format= None):
        users = User.objects.all()
        serializer = UserSerializer(users,  many = True)
        return Response(serializer.data)

    #To create the user
    def post(self, request):
        serializer = UserSerializer(data = request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
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
