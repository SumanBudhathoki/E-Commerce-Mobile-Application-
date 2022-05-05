import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class UserState with ChangeNotifier {
  LocalStorage storage = LocalStorage("usertoken");
  int? id;
  Future<bool> loginNow(String username, String password) async {
    try {
      String url = 'http://10.0.2.2:8000/api/login/';
      http.Response response = await http.post((Uri.parse(url)),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data.containsKey('token')) {
        storage.setItem('token', data['token']);
        return true;
      }
      return false;
    } catch (e) {
      // print("Error in login");
      print(e);
      return false;
    }
  }

  Future<bool> getUserInfo(String username, String password) async {
    try {
      String url = 'http://10.0.2.2:8000/api/api-token-auth/';
      http.Response response = await http.post((Uri.parse(url)),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      var data = json.decode(response.body) as Map;
      // print(data);
      if (data['is_seller'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print("Error in getting user info");
      print(e);
      return false;
    }
  }

  Future<int?> getUserId(String username, String password) async {
    try {
      String url = 'http://10.0.2.2:8000/api/api-token-auth/';
      http.Response response = await http.post((Uri.parse(url)),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      var data = json.decode(response.body) as Map;
      // print(data);
      id = data['user_id'];
      // print(id);

      // return false;
    } catch (e) {
      print("Error in getting user id");
      print(e);
      // return false;
    }
    // return null;
  }

  Future<bool> registerNow(
      String username, String password, String email, String address) async {
    try {
      String url = 'http://10.0.2.2:8000/api/register/';
      http.Response response = await http.post(
        (Uri.parse(url)),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          'username': username,
          'password': password,
          'email': email,
          'address': address,
        }),
      );
      var data = json.decode(response.body) as Map;
      // print(data);
      return data['error'];
    } catch (e) {
      print("Error in register");
      print(e);
      return true;
    }
  }

  Future<bool> registerNowSeller(String username, String password, String email,
      String address, String shopName) async {
    try {
      String url = 'http://10.0.2.2:8000/api/register/seller/';
      http.Response response = await http.post(
        (Uri.parse(url)),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          'username': username,
          'password': password,
          'email': email,
          'address': address,
          'shopName': shopName,
        }),
      );
      var data = json.decode(response.body) as Map;
      // print(data);
      return data['error'];
    } catch (e) {
      print("Error in register");
      print(e);
      return true;
    }
  }

  int? getId() {
    return id;
  }
}
