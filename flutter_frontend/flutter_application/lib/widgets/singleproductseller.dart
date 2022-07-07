import 'package:flutter/material.dart';
import 'package:flutter_application/screens/deleteproduct.dart';
import 'package:flutter_application/screens/product_detail.dart';
import 'package:flutter_application/screens/updateproduct.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';

class SingleProductSeller extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  // final bool favourite;

  const SingleProductSeller({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              UpdateProductScreen.routeName,
              arguments: id,
            );
          },
          child: Icon(Icons.edit),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: id,
          );
          // print(id);
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
            Navigator.of(context).pushNamed(
              DeleteProductScreen.routeName,
              arguments: id,
            );
          },
          child: Icon(Icons.delete),
        ),
      ),
    );
  }
}
