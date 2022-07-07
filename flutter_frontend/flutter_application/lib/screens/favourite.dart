import 'package:flutter/material.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/single_product.dart';

class FavouriteScreen extends StatelessWidget {
  static const routeName = '/favourite-screen';
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<ProductState>(context).favourites;
    final favouriteLength = favourite.length;
    if (favouriteLength >= 1) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Favourites"),
        ),
        drawer: const AppDrawer(),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 3,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: favourite.length,
          itemBuilder: (context, i) => SingleProduct(
            id: favourite[i].id!,
            title: favourite[i].title!,
            image: favourite[i].image!,
            favourite: favourite[i].favourite!,
            sellingPrice: favourite[i].sellingPrice!,
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Favourites"),
          ),
          drawer: const AppDrawer(),
          body: const Center(
            child: Text("No items in your favourite list"),
          ));
    }
  }
}
