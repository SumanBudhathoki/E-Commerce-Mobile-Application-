import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const Text("Hello User "),
          const Spacer(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            trailing: const Icon(Icons.logout),
            title: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
