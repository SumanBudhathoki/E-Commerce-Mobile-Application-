import 'package:flutter/material.dart';
import 'package:flutter_application/screens/favourite.dart';
import 'package:flutter_application/screens/homescreen.dart';
import 'package:flutter_application/screens/product_detail.dart';
import 'package:flutter_application/screens/register.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/state/user_state.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // create: (context) => UserState(),
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          FavouriteScreen.routeName: (context) => const FavouriteScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
