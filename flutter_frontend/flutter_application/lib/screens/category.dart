import 'package:flutter/material.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/search.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/single_category.dart';
import '../widgets/single_product.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category-screen';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final product = Provider.of<ProductState>(context).categorypost(id);
    final category = Provider.of<ProductState>(context).category;
    final productlength = product.length;

    if (productlength >= 1) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.blue,
                child: Row(
                  children: [
                    BackButton(),
                    Text(
                      category[id - 1].title!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 2,
              ),
              const Divider(
                height: 2,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 3,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: product.length,
                  itemBuilder: (context, i) => SingleProduct(
                    id: product[i].id!,
                    title: product[i].title!,
                    image: product[i].image!,
                    favourite: product[i].favourite!,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      const BackButton(),
                      Text(
                        category[id - 1].title!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                Text("No items in this category"),
              ],
            ),
          ),
        ),
      );
    }
  }
}
