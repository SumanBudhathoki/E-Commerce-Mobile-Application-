import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application/models/cart.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class CartState with ChangeNotifier {
  LocalStorage storage = LocalStorage('usertoken');
  CartModel? _cartModel;
  late List<OrderModel> _oldOrder;

  Future<void> getCartData() async {
    String url = 'http://10.0.2.2:8000/api/cart';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;

      List<CartModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          CartModel cartModel = CartModel.fromJson(element);
          demo.add(cartModel);
        });
        _cartModel = demo[0];
        notifyListeners();
      } else {
        print(data['data']);
      }
    } catch (e) {
      // print(e);
      print("Error in getCartData");
    }
  }

  Future<void> getoldOrders() async {
    String url = 'http://10.0.2.2:8000/api/order';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      // print(data);
      List<OrderModel> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          OrderModel oldOrder = OrderModel.fromJson(element);
          demo.add(oldOrder);
        });
        _oldOrder = demo;
        notifyListeners();
      } else {
        print(data['data']);
      }
    } catch (e) {
      // print(e);
      print("Error in getoldOrder");
    }
  }

  Future<void> addtoCart(id) async {
    String url = 'http://10.0.2.2:8000/api/addtocart/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'id': id,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $token"
        },
      );
      var data = json.decode(response.body) as Map;

      if (data['error'] == false) {
        getCartData();
      }
    } catch (e) {
      print(e);
      print("Error in add to cart");
    }
  }

  Future<bool> orderCart(
      int? cartid, String email, String address, String phone) async {
    String url = 'http://10.0.2.2:8000/api/ordernow/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(
        (Uri.parse(url)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $token"
        },
        body: json.encode({
          "cartid": cartid,
          "email": email,
          "address": address,
          "phone": phone,
        }),
      );
      var data = json.decode(response.body) as Map;
      // print(data);
      if (data['error'] == false) {
        getCartData();
        getoldOrders();
        // _cartModel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      print("Error in ordernow section of cart");
      return false;
    }
  }

  Future<void> deleteCartProduct(id) async {
    String url = 'http://10.0.2.2:8000/api/deletecartproduct/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        body: json.encode({
          'id': id,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $token"
        },
      );
      var data = json.decode(response.body) as Map;
      // print(data);
      if (data['error'] == false) {
        getCartData();
      }
    } catch (e) {
      print(e);
      print("Error in delete from cart");
    }
  }

  Future<bool> deleteAllCart(id) async {
    String url = 'http://10.0.2.2:8000/api/deleteallcart/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        body: json.encode({
          'id': id,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $token"
        },
      );
      var data = json.decode(response.body) as Map;
      // print(data);
      if (data['error'] == false) {
        getCartData();
        // _cartModel = null;
        notifyListeners();

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      print("Error in delete from cart");
      return false;
    }
  }

  List<OrderModel>? get oldOrder {
    if (_oldOrder != null) {
      return [..._oldOrder];
    } else {
      return null;
    }
  }

  CartModel? get cartModel {
    if (_cartModel != null) {
      return _cartModel;
    } else {
      return null;
    }
  }
}
