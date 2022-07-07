import 'package:flutter/material.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/homepage.dart';
import 'package:flutter_application/screens/login.dart';
import 'package:flutter_application/theme.dart';
import '../screens/favourite.dart';

class BuyerButtomNavBar extends StatefulWidget {
  @override
  State<BuyerButtomNavBar> createState() => _BuyerButtomNavBarState();
}

class _BuyerButtomNavBarState extends State<BuyerButtomNavBar> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    FavouriteScreen(),
    CartScreen(),
    LoginScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => setState(() {
        currentIndex = index;
      }),
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      iconSize: 25,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kDarkGreyColor,
      items: [
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
    );
  }
}
