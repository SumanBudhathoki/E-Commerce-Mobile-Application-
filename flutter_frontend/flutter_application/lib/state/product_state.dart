import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application/models/product.dart';
import 'package:http/http.dart' as http;

class ProductState with ChangeNotifier {
  List<Product> _products = [];

  Future<bool> getProducts() async {
    String url = 'http://10.0.2.2:8000/api/products';
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Authorization': "token f537bc45ca003a76c7a14aef106ecbc225caa1bb"
      });
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

  Future<void> favourite(int id) async {
    String url = 'http://10.0.2.2:8000/api/favourite/';
    try {
      // ignore: unused_local_variable
      http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'id': id,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token f537bc45ca003a76c7a14aef106ecbc225caa1bb"
        },
      );
      getProducts();
    } catch (e) {
      print("Error in favourite");
      print(e);
    }
  }

  List<Product> get product {
    return [..._products];
  }

  List<Product> get favourites {
    return _products.where((element) => element.favourite == true).toList();
  }

  Product singleProduct(id) {
    return _products.firstWhere((element) => element.id == id);
  }
}
