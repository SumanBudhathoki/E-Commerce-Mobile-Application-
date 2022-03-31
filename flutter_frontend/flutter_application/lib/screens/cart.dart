import 'package:flutter/material.dart';
import 'package:flutter_application/models/cart.dart';
import 'package:flutter_application/screens/homescreen.dart';
import 'package:flutter_application/screens/order_screen.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final id = ModalRoute.of(context)!.settings.arguments;
    final cart = Provider.of<CartState>(context).cartModel;
    if (cart == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart Screen"),
        ),
        body: const Center(child: Text("Nothing in the cart")),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart Screen"),
          actions: [
            FlatButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                cart != null ? "${cart.cartproducts?.length}" : '',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Total : Rs ${cart.total}"),
                Text("Data : ${cart.date}"),
                ElevatedButton(
                  onPressed: cart.cartproducts!.isEmpty
                      ? null
                      : () {
                          Navigator.of(context)
                              .pushNamed(OrderScreen.routeName);
                        },
                  child: const Text("Order"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[500],
                  ),
                ),
                ElevatedButton(
                  onPressed: cart.cartproducts!.isEmpty
                      ? null
                      : () async {
                          bool isdelete = await Provider.of<CartState>(context,
                                  listen: false)
                              .deleteAllCart(cart.id);
                          if (isdelete) {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeName);
                          }
                        },
                  child: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[500],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartproducts!.length,
                itemBuilder: (context, i) {
                  var item = cart.cartproducts![i];
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item.product![0].title}"),
                            Text("Price : Rs ${item.price}"),
                            Text("Quantity : ${item.quantity}")
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<CartState>(context, listen: false)
                                .deleteCartProduct(item.id);
                          },
                          child: const Text("Delete"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[500],
                          ),
                        ),
                      ],
                    ),
                  ));
                },
              ),
            )
          ]),
        ),
      );
    }
  }
}
