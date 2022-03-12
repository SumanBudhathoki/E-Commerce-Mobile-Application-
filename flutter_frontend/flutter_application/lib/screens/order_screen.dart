import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      drawer: const AppDrawer(),
    );
  }
}
