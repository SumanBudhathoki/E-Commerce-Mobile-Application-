import 'package:flutter/material.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/search.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/theme.dart';
import 'package:flutter_application/widgets/single_category.dart';
import 'package:flutter_application/widgets/single_product.dart';
import 'package:flutter_application/widgets/slider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _init = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<ProductState>(context).getCategoryData();
      Provider.of<CartState>(context).getoldOrders();
      Provider.of<CartState>(context).getCartData();
      _isLoading = await Provider.of<ProductState>(context).getProducts();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).product;
    final cart = Provider.of<CartState>(context).cartModel;
    final category = Provider.of<ProductState>(context).category;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchPage()));
          },
          icon: const Icon(
            Icons.search,
            size: 28,
            color: Colors.black,
          ),
        ),
        title: const Center(
          child: Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          // ignore: deprecated_member_use
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            label: Text(
              cart != null ? "${cart.cartproducts?.length}" : '',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const ImageSlider(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Category',
              style: sTitleText.copyWith(
                color: kBlackColor,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(
            height: 70,
            // decoration: BoxDecoration(border: Border.all(width: 1)),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (context, i) => SingleCategory(
                      category: category[i],
                      image: category[i].image!,
                    )),
          ),
          const Divider(
            height: 2,
            thickness: 0.7,
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Just For You',
              style: sTitleText.copyWith(
                color: kBlackColor,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
              sellingPrice: product[i].sellingPrice!,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
