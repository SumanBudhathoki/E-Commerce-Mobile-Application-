import 'package:flutter/material.dart';
import 'package:flutter_application/screens/product_detail.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';

class SingleProduct extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final bool favourite;

  const SingleProduct(
      {Key? key,
      required this.id,
      required this.title,
      required this.image,
      required this.favourite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<ProductState>(context, listen: false).favourite(id);
          },
          icon: Icon(
            favourite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: id,
          );
          print(id);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.network(
            "http://10.0.2.2:8000$image",
            fit: BoxFit.cover,
          ),
        ),
      ),
      footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(title),
          trailing: InkWell(
              onTap: () {
                Provider.of<CartState>(context, listen: false).addtoCart(id);
              },
              child: Icon(Icons.shopping_cart))),
    );
  }
}
