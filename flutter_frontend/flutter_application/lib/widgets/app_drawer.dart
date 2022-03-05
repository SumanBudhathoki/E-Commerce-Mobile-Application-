import 'package:flutter/material.dart';
import 'package:flutter_application/screens/homescreen.dart';
import 'package:flutter_application/screens/login.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Welcome !"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            trailing: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: const Text("Home"),
          ),
          ListTile(
            onTap: () {},
            trailing: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: const Text("Favourite"),
          ),
          const Spacer(),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            trailing: const Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            title: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
