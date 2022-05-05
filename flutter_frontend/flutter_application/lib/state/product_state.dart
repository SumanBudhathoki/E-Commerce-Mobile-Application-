import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application/models/category_model.dart';
import 'package:flutter_application/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ProductState with ChangeNotifier {
  LocalStorage storage = LocalStorage("usertoken");
  List<Product> _products = [];
  List<Category> _category = [];

  Future<bool> getProducts() async {
    String url = 'http://10.0.2.2:8000/api/products';
    var token = storage.getItem('token');
    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
      // print(data);
      List<Product> temp = [];
      // ignore: avoid_function_literals_in_foreach_calls
      data.forEach((element) {
        Product product = Product.fromJson(element);
        temp.add(product);
      });
      _products = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("Error in getProducts");
      print(e);
      return false;
    }
  }

  Future<void> getCategoryData() async {
    String url = 'http://10.0.2.2:8000/api/category';
    var token = storage.getItem('token');
    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Authorization': "token $token"});
      var data = json.decode(response.body) as List;
      // print(data);
      List<Category> temp = [];
      for (var element in data) {
        Category category = Category.fromJson(element);
        temp.add(category);
      }
      _category = temp;
      notifyListeners();
    } catch (e) {
      print("Error in get category");
      print(e);
    }
  }

  Future<void> favourite(id) async {
    String url = 'http://10.0.2.2:8000/api/favourite/';
    var token = storage.getItem('token');

    try {
      // ignore: unused_local_variable
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
      getProducts();
    } catch (e) {
      print("Error in favourite");
      print(e);
    }
  }

  Future<bool> postads(String? title, String? price, String? description,
      String? catagory, File? selectedImage) async {
    String url = 'http://10.0.2.2:8000/api/addproducts/';
    var token = storage.getItem('token');

    try {
      http.Response response = await http.post(
        (Uri.parse(url)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $token"
        },
        body: json.encode({
          "title": title,
          "selling_price": price,
          "description": description,
          "catgory": catagory,
        }),
      );
      var data = json.decode(response.body) as Map;
      print(data);
      if (data['error'] == false) {
        getProducts();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      print("Error in post ad section ");
      return false;
    }
  }

  List<Product> get product {
    return [..._products];
  }

  List<Category> get category {
    return [..._category];
  }

  List<Product> get favourites {
    return _products.where((element) => element.favourite == true).toList();
  }

  Product singleProduct(id) {
    return _products.firstWhere((element) => element.id == id);
  }

  List<Product> categorypost(id) {
    return _products.where((element) => element.category == id).toList();
  }

  List<Product> ownerProduct(id) {
    return _products.where((element) => element.user == id).toList();
  }
}
