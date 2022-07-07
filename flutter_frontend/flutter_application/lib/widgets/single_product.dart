import 'package:flutter/material.dart';
import 'package:flutter_application/theme.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';
import '../state/product_state.dart';

class SingleProduct extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final bool favourite;
  final int sellingPrice;

  const SingleProduct({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.favourite,
    required this.sellingPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    "http://10.0.2.2:8000$image",
                    height: 0.25 * height,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ProductState>(context, listen: false)
                        .favourite(id);
                  },
                  icon: Icon(
                    favourite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: subTitle,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                            text: '  Rs ',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                        TextSpan(
                            text: sellingPrice.toString(),
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartState>(context, listen: false)
                            .addtoCart(id);
                      },
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return GridTile(
    //   header: GridTileBar(
    //     leading: IconButton(
    //       onPressed: () {
    //         Provider.of<ProductState>(context, listen: false).favourite(id);
    //       },
    //       icon: Icon(
    //         favourite ? Icons.favorite : Icons.favorite_border,
    //         color: Colors.red,
    //       ),
    //     ),
    //   ),
    //   child: GestureDetector(
    //     onTap: () {
    //       Navigator.of(context).pushNamed(
    //         ProductDetailScreen.routeName,
    //         arguments: id,
    //       );
    //       // print(id);
    //     },
    //     child: Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Image.network(
    //         "http://10.0.2.2:8000$image",
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    //   footer: GridTileBar(
    //       backgroundColor: Colors.black54,
    //       title: Text(title),
    //       trailing: InkWell(
    //           onTap: () {
    //             Provider.of<CartState>(context, listen: false).addtoCart(id);
    //           },
    //           child: Icon(Icons.shopping_cart))),
    // );
    // }
  }
}
