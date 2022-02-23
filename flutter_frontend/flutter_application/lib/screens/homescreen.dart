import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
    );
  }
}
