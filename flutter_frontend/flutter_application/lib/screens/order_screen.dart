import 'package:flutter/material.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/order_history_screen.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _email = '';
  String _phone = '';
  String _address = '';
  final _form = GlobalKey<FormState>();

  void _orderNow() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    final cart = Provider.of<CartState>(context, listen: false).cartModel;
    var order = await Provider.of<CartState>(context, listen: false)
        .orderCart(cart?.id, _email, _address, _phone);
    if (order) {
      Navigator.of(context).pushNamed(OrderHistoryScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter your email";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _email = v!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Phone Number"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter your phone number";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _phone = v!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Address"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter your address";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _address = v!;
                  },
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _orderNow();
                      },
                      child: Text("Order Now"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      child: Text("Edit Cart"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
