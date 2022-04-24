from rest_framework import generics, filters
from .serializers import * #serializers that we created 
from .models import *
from rest_framework.views import APIView #Class based views
from rest_framework.response import Response #For response
from rest_framework import status #Status code for imformative response
from django.contrib.auth.models import User
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from rest_framework.generics import ListCreateAPIView
from rest_framework.authtoken.views import ObtainAuthToken

class GetUserData(ObtainAuthToken):
     def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'email': user.email,
            'is_seller': user.is_seller,            
        })
 
class UserRegistration(APIView):    
    # To create the user
    def post(self, request):
        data = request.data
        serializer = UserSerializer(data = request.data)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            user = CustomUser.objects.get(username = serializer.data['username'])
            address = data['address']
            buyer = Retailer.objects.create(
                user = user,
                address = address
            )
            buyer.save()
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
class UserRegistrationSeller(APIView):
    # To create the user
    def post(self, request):
        data = request.data
        
        serializer = UserSerializer(data = request.data)
        # print(serializer)
        if serializer.is_valid():  
            serializer.save()
            user = CustomUser.objects.get(username = serializer.data['username'])
            address = data['address']
            shopName = data['shopName']
            
            seller = Wholesaler.objects.create(
                user = user,
                address = address,
                shop_name = shopName
            )            
            seller.save()
            user_id = seller.user.id            
            CustomUser.objects.filter(id = user_id).update(is_seller = True)

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
class ProductSearchView(generics.ListCreateAPIView):
    search_fields = ['title']
    filter_backends = (filters.SearchFilter,)
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

class ProductView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication,]
    def get(self, request):
        # search_fields = ['title', 'selling_price']
        # filter_backend = (filter.SearchFilter,)
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

class ProductAddView(ListCreateAPIView):
    # permission_classes = [IsAuthenticated, ]
    # authentication_classes = [TokenAuthentication,]
    try:
        serializer_class = ProductSerializer

        def perform_create(self, serializer):
            serializer.save()
            response_msg = {'error': False}
            return Response(response_msg)       
    except:
        response_msg = {'error': True}
        
    # def get_queryset(self):
    #     return Product.objects.all(/)

# class TestImageView(ListCreateAPIView):
#     try:
#         serializer_class = TestImage

#         def perform_create(self, serializer):
#             serializer.save()
#             response_msg = {'error': False}
#             return Response(response_msg)       
#     except:
#         response_msg = {'error': True} 
        

class CategoryView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Category.objects.all()
        serializer = CategorySerializer(query, many=True)
        return Response(serializer.data)

            
class FavouriteView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication]
    def post(self, request):        
        id= request.data["id"]
        print(id)
        try:
            product_obj = Product.objects.get(id = id)
            user = request.user
            single_fav_product = Favourite.objects.filter(user = user).filter(product= product_obj).first()
            if single_fav_product:
                print("Single Favourite Product")
                ccc = single_fav_product.isFavorite
                single_fav_product.isFavorite = not ccc
                single_fav_product.save()
            else:
                Favourite.objects.create(
                    product = product_obj, user = user, isFavorite = True
                )
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)
          
class CartView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication]

    def get(self, request):
        user = request.user
        try:
            # cart_obj = Cart.objects.filter(user=user).filter(isComplete==False)
            cart_obj = Cart.objects.filter(user=user).filter(isComplete=False)
            data = []
            cart_serializer = CartSerializer(cart_obj, many= True)
            for cart in cart_serializer.data:
                cart_product_obj = CartProduct.objects.filter(cart = cart['id'])
                cart_product_obj_serializer = CartProductSerializer(cart_product_obj, many = True)
                cart['cartproducts'] = cart_product_obj_serializer.data
                data.append(cart)
            response_msg = {"error": False, "data": data}
        except:
            response_msg= {"error": True, "data": "No data available"}
        return Response(response_msg)
        
class OrderView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication]

    def get(self, request):
        user = request.user

        try:
            order_obj = Order.objects.filter(cart__user = user)
            order_serializer = OrderSerializer(order_obj, many = True)
            response_msg = {"error": False, "data": order_serializer.data}
        except:
            response_msg = {"error": True, "data": "No data available"}
        return Response(response_msg)            


class AddToCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        product_id = request.data['id']
        product_obj = Product.objects.get(id=product_id)
        # print(product_obj, "product_obj")
        cart_cart = Cart.objects.filter(
            user=request.user).filter(isComplete=False).first()
        cart_product_obj = CartProduct.objects.filter(
            product__id=product_id).first()

        try:
            if cart_cart:
                print(cart_cart)
                print("OLD CART")
                this_product_in_cart = cart_cart.cartproduct_set.filter(
                    product=product_obj)
                if this_product_in_cart.exists():
                    cartprod_uct = CartProduct.objects.filter(
                        product=product_obj).filter(cart__isComplete=False).first()
                    cartprod_uct.quantity = cartprod_uct.quantity + 1
                    cartprod_uct.subtotal += product_obj.selling_price
                    cartprod_uct.save()
                    cart_cart.total += product_obj.selling_price
                    cart_cart.save()
                else:
                    print("NEW CART PRODUCT CREATED--OLD CART")
                    cart_product_new = CartProduct.objects.create(
                        cart=cart_cart,
                        price=product_obj.selling_price,
                        quantity=1,
                        subtotal=product_obj.selling_price
                    )
                    cart_product_new.product.add(product_obj)
                    cart_cart.total += product_obj.selling_price
                    cart_cart.save()
            else:
                Cart.objects.create(user=request.user,
                                    total=0, isComplete=False)
                new_cart = Cart.objects.filter(
                    user=request.user).filter(isComplete=False).first()
                cart_product_new = CartProduct.objects.create(
                    cart=new_cart,
                    price=product_obj.selling_price,
                    quantity=1,
                    subtotal=product_obj.selling_price
                )
                cart_product_new.product.add(product_obj)
                new_cart.total += product_obj.selling_price
                new_cart.save()
            response_mesage = {
                'error': False, 'message': "Product added to card successfully", "productid": product_id}
        except:
            response_mesage = {'error': True,
                               'message': "There is some problem adding product to the cart"}
        return Response(response_mesage)


class DeleteCartProduct(APIView):
    authentication_classes = [TokenAuthentication,]
    permission_classes = [IsAuthenticated,]

    def delete(self, request):
        cart_product_id = request.data['id']
        try:
            cart_product_obj = CartProduct.objects.get(id = cart_product_id)
            cart_cart = Cart.objects.filter(user = request.user).filter(isComplete=False).first()
            cart_cart.total -= cart_product_obj.subtotal
            cart_product_obj.delete()
            cart_cart.save()
            response_msg = {'error': False}
        except:
            response_msg= {'error': True}
        return Response(response_msg)

# class DeleteAllCart(APIView):
#     authentication_classes = [TokenAuthentication,]
#     permission_classes = [IsAuthenticated,]

#     def delete(self, request):
#         cart_id = request.data['id']
#         try:
#             all_cart = Cart.objects.get(id = cart_id)
#             all_cart.delete()
#             response_msg = {'error': False}
#         except:
#             response_msg = {'error': True}
#         return Response(response_msg)

class DeleteAllCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def delete(self, request):
        cart_id = request.data['id']
        try:
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.delete()
            
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)

class OrderCreateView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        try:
            data = request.data
            cart_id = data['cartid']
            address = data['address']
            email = data['email']
            phone = data['phone']
            cart_obj = Cart.objects.get(id= cart_id)
            cart_obj.isComplete = True
            cart_obj.save()
            Order.objects.create(
                cart = cart_obj,
                email = email,
                address = address, 
                phone = phone,
            )
            response_msg = {"error": False, "message": "Your Order is Completed."}

        except:
            response_msg = {"error": True, "message": "Something is wrong! Please try again later."}

        return Response(response_msg)
    