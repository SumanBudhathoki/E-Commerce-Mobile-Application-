import 'package:flutter/material.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/theme.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product--details-screen";

  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final product = Provider.of<ProductState>(context).singleProduct(id);
    final cart = Provider.of<CartState>(context).cartModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
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
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network(
              "http://10.0.2.2:8000${product.image}",
              fit: BoxFit.contain,
              height: 250,
              width: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.title!,
                    style: titleText,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<CartState>(context, listen: false)
                        .addtoCart(id!);
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Add to Cart"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Selling Price: Rs",
                  style: subTitle.copyWith(fontSize: 20),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  product.sellingPrice!.toString(),
                  style: subTitle.copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.description!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                height: 1.45,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
