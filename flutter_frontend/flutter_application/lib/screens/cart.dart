import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home.dart';
import 'package:flutter_application/screens/order_screen.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/theme.dart';
import 'package:provider/provider.dart';

import '../state/product_state.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).product;
    final cart = Provider.of<CartState>(context).cartModel;

    if (cart == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text("Cart Screen"),
        ),
        body: const Center(child: Text("Nothing in the cart")),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: kPrimaryColor,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text("Cart"),
          actions: [
            FlatButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: kPrimaryColor,
              ),
              label: Text(
                cart != null ? "${cart.cartproducts?.length}" : '',
                style: const TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cart.cartproducts!.length,
                itemBuilder: (context, i) {
                  var item = cart.cartproducts![i];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ListTile(
                      leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          "http://10.0.2.2:8000${cart.cartproducts![i].product![0].image}",
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.product![0].title}",
                                style: sTitleText.copyWith(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Price : Rs ${item.price}",
                                style: subTitle,
                              ),
                              Text(
                                "Quantity : ${item.quantity}",
                                style: subTitle,
                              ),
                            ],
                          ),
                          Column(children: [
                            IconButton(
                              onPressed: () {
                                Provider.of<CartState>(context, listen: false)
                                    .deleteCartProduct(item.id);
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              // child: const Text("Delete"),
                              // style: ElevatedButton.styleFrom(
                              //   primary: Colors.red[500],
                              // ),
                            ),
                            Container(
                              width: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.remove_circle_rounded,
                                    size: 20,
                                    color: kPrimaryColor,
                                  ),
                                  Text(
                                    "${item.quantity}",
                                    style: sTitleText.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    child: const Icon(
                                      Icons.add_circle_rounded,
                                      size: 20,
                                      color: kPrimaryColor,
                                    ),
                                    onTap: () {
                                      item.quantity = item.quantity! + 1;
                                    },
                                  )
                                ],
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: sTitleText.copyWith(fontSize: 22),
                  ),
                  Text("Rs ${cart.total}",
                      style: sTitleText.copyWith(fontSize: 22)),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: cart.cartproducts!.isEmpty
                        ? null
                        : () async {
                            bool isdelete = await Provider.of<CartState>(
                                    context,
                                    listen: false)
                                .deleteAllCart(cart.id);
                            if (isdelete) {
                              // cart.total = 0;
                              Navigator.of(context)
                                  .pushReplacementNamed(Home.routeName);
                            }
                          },
                    child: const Text("Delete"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[500],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
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
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ]),
          ]),
        ),
      );
    }
  }
}
