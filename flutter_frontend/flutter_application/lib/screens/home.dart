import 'package:flutter/material.dart';
import 'package:flutter_application/screens/addproduct.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/homepage.dart';
import 'package:flutter_application/screens/myshop.dart';
import 'package:provider/provider.dart';
import '../state/user_state.dart';
import '../theme.dart';
import 'favourite.dart';
import 'login.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final buyerscreens = [
    HomePage(),
    FavouriteScreen(),
    CartScreen(),
    LoginScreen(),
  ];
  final sellerscreens = [
    HomePage(),
    AddProductScreen(),
    MyShop(),
    LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<UserState>(context).getType();

    if (userType == false) {
      return Scaffold(
        body: buyerscreens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          currentIndex: currentIndex,
          backgroundColor: Colors.white,
          iconSize: 25,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kDarkGreyColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_outlined),
              label: 'Logout',
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: sellerscreens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          currentIndex: currentIndex,
          backgroundColor: Colors.white,
          iconSize: 25,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kDarkGreyColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'My Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_outlined),
              label: 'Logout',
            ),
          ],
        ),
      );
    }
  }
}
