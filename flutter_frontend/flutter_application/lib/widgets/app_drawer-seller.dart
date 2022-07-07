import 'package:flutter/material.dart';
import 'package:flutter_application/screens/addproduct.dart';
import 'package:flutter_application/screens/homepage.dart';
import 'package:flutter_application/screens/login.dart';
import 'package:flutter_application/screens/myshop.dart';
import 'package:localstorage/localstorage.dart';

class AppDrawerSeller extends StatefulWidget {
  const AppDrawerSeller({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawerSeller> createState() => _AppDrawerSellerState();
}

class _AppDrawerSellerState extends State<AppDrawerSeller> {
  LocalStorage storage = LocalStorage('usertoken');

  void _logoutNow() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

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
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
            trailing: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: const Text("Home"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MyShop.routeName);
            },
            trailing: const Icon(
              Icons.store,
              color: Colors.blue,
            ),
            title: const Text("My Shop"),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(FavouriteScreen.routeName);
          //   },
          //   trailing: const Icon(
          //     Icons.favorite,
          //     color: Colors.red,
          //   ),
          //   title: const Text("Favourites"),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(OrderHistoryScreen.routeName);
          //   },
          //   trailing: const Icon(
          //     Icons.history,
          //     color: Colors.blue,
          //   ),
          //   title: const Text("Order History"),
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AddProductScreen.routeName);
            },
            trailing: const Icon(
              Icons.create,
              color: Colors.blue,
            ),
            title: const Text("Post Ads"),
          ),
          const Spacer(),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              _logoutNow();
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
