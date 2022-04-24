import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/app_drawer-seller.dart';

class MyShop extends StatefulWidget {
  static const routeName = '/my-shop';
  const MyShop({Key? key}) : super(key: key);

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  // final userData = ModalRoute.of(context)!.settings.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerSeller(),
      appBar: AppBar(title: Text("My Shop")),
    );
  }
}
