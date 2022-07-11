import 'package:flutter/material.dart';
import 'package:flutter_application/screens/addproduct.dart';
import 'package:flutter_application/screens/favourite.dart';
import 'package:flutter_application/screens/homepage.dart';
import 'package:provider/provider.dart';
import '../state/product_state.dart';
import '../theme.dart';
import 'package:flutter_application/screens/login.dart';
import 'package:flutter_application/theme.dart';
import 'package:localstorage/localstorage.dart';

import '../screens/order_history_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  LocalStorage storage = LocalStorage('usertoken');

  void _logoutNow() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<ProductState>(context).category;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: kPrimaryColor,
          title: const Text('User Profile'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CircleAvatar(
                radius: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/suman.jpg',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Suman Budhathoki',
              style: sTitleText.copyWith(fontSize: 25),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              'sbudhathoki639@gmail.com',
              style: subTitle.copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    shadowColor: kBlackColor,
                    elevation: 3,
                    color: kPrimaryColor1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Cart Item',
                            style: sTitleText.copyWith(
                                fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "20",
                            style: sTitleText.copyWith(
                                fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    shadowColor: kBlackColor,
                    elevation: 3,
                    color: kPrimaryColor1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Favourite Item',
                            style: sTitleText.copyWith(
                                fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "6",
                            style: sTitleText.copyWith(
                                fontSize: 22, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }
}
