import 'package:flutter/material.dart';
import 'package:flutter_application/screens/addproduct.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/category.dart';
import 'package:flutter_application/screens/favourite.dart';
import 'package:flutter_application/screens/homescreen.dart';
import 'package:flutter_application/screens/order_history_screen.dart';
import 'package:flutter_application/screens/order_screen.dart';
import 'package:flutter_application/screens/payment_selection.dart';
import 'package:flutter_application/screens/product_detail.dart';
import 'package:flutter_application/screens/registerbuyer.dart';
import 'package:flutter_application/screens/registerseller.dart';
import 'package:flutter_application/screens/stipe_payment.dart';
import 'package:flutter_application/screens/uploadimage.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/state/user_state.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51KnQosJgnzsLEBhImVUvO7rTTyr6lfDs4qb0aLrNDtY0l2IKcZIkZc44VMoWi3isFtF13EbCiOFeljVg420UXLe100n1RZsbla';
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
      child: KhaltiScope(
        publicKey: "test_public_key_3b5bbe2fb6464003a2d1f0356cea8ad9",
        builder: (BuildContext, navigatorKey) {
          return MaterialApp(
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
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
              // HomeScreen.routeName: (context) => const ImageUpload(),
              ProductDetailScreen.routeName: (context) =>
                  const ProductDetailScreen(),
              CategoryScreen.routeName: (context) => const CategoryScreen(),
              FavouriteScreen.routeName: (context) => const FavouriteScreen(),
              AddProductScreen.routeName: (context) => const AddProductScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              OrderScreen.routeName: (context) => const OrderScreen(),
              OrderHistoryScreen.routeName: (context) =>
                  const OrderHistoryScreen(),
              StripePayment.routeName: (context) => const StripePayment(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              RegisterScreenRetailer.routeName: (context) =>
                  const RegisterScreenRetailer(),
              RegisterScreenSeller.routeName: (context) =>
                  const RegisterScreenSeller(),
              PaymentOption.routeName: (context) => const PaymentOption(),
            },
          );
        },
      ),
    );
  }
}
