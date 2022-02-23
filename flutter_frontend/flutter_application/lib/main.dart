import 'package:flutter/material.dart';
import 'package:flutter_application/screens/homescreen.dart';
import 'package:flutter_application/screens/register.dart';
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
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: const LoginScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
        },
      ),
    );
  }
}
