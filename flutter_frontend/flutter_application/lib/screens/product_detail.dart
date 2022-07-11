import 'package:flutter/material.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/theme.dart';
import 'package:flutter_application/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = "/product--details-screen";

  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isHover = true;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final product = Provider.of<ProductState>(context).singleProduct(id);

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: kPrimaryColor,
          iconTheme: const IconThemeData(size: 28),
        ),
        body: Stack(
          children: [
            MouseRegion(
              onEnter: (f) {
                setState(() {
                  isHover = true;
                });
              },
              onExit: (f) {
                setState(() {
                  isHover = false;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Image(
                    image: NetworkImage("http://10.0.2.2:8000${product.image}",
                        scale: 1.2),
                    fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.32,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, -4),
                          blurRadius: 8),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 25,
                    right: 25,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.title!,
                                style: titleText.copyWith(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Provider.of<ProductState>(context,
                                        listen: false)
                                    .favourite(id);
                              },
                              child: Icon(
                                product.favourite!
                                    ? Icons.favorite_sharp
                                    : Icons.favorite_border_sharp,
                                size: 35,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price",
                              style: sTitleText.copyWith(fontSize: 20),
                            ),
                            Text(
                              ("Rs. ${product.sellingPrice!}"),
                              style: sTitleText.copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Description',
                          style: sTitleText.copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.description!,
                          style: subTitle.copyWith(fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                            onTap: () {
                              Provider.of<CartState>(context, listen: false)
                                  .addtoCart(id!);
                            },
                            child:
                                const PrimaryButton(buttonText: 'Add To Cart')),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
