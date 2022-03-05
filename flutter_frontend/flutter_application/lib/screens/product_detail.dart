import 'package:flutter/material.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/theme.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product--details-screen";
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final product = Provider.of<ProductState>(context).singleProduct(id);
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: Padding(
        padding: EdgeInsets.all(10),
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
                  onPressed: () {},
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
