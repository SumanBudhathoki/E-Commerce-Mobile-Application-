import 'package:flutter/material.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/favourite.dart';
import 'package:flutter_application/screens/homescreen.dart';
import 'package:flutter_application/screens/order_history_screen.dart';
import 'package:flutter_application/screens/order_screen.dart';
import 'package:flutter_application/screens/product_detail.dart';
import 'package:flutter_application/screens/register.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/state/user_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");
    return MultiProvider(
      // create: (context) => UserState(),

      providers: [
        ChangeNotifierProvider(
          create: (context) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductState(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartState(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: FutureBuilder(
          future: storage.ready,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return const LoginScreen();
            }
            return const HomeScreen();
          },
        ),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          FavouriteScreen.routeName: (context) => const FavouriteScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrderScreen.routeName: (context) => const OrderScreen(),
          OrderHistoryScreen.routeName: (context) => const OrderHistoryScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
