import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class UserState with ChangeNotifier {
  LocalStorage storage = LocalStorage("usertoken");

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
      // print(data);
      storage.setItem('token', data['token']);
      // print(storage.getItem('token'));
      if (data.containsKey('token')) {
        return false;
      }
      return true;
    } catch (e) {
      print("Error in login");
      print(e);
    }
    return true;
  }

  // LocalStorage storage = LocalStorage("usertoken");

  Future<bool> registerNow(
      String username, String password, String email) async {
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
        }),
      );
      var data = json.decode(response.body) as Map;
      print(data);
      return data['error'];
    } catch (e) {
      print("Error in register");
      print(e);
      return true;
    }
  }
}
