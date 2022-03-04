import 'package:flutter/material.dart';

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
      header: const GridTileBar(),
      child: Image.network(
        "http://10.0.2.2:8000$image",
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(title),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            favourite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
