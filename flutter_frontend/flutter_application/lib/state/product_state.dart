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
      data.forEach((element) {
        Product product = Product.fromJson(element);
        temp.add(product);
      });
      _products = temp;
      return true;
    } catch (e) {
      // print("Error in getProducts");
      // print(e);
      return false;
    }
  }

  List<Product> get product {
    return [..._products];
  }
}
