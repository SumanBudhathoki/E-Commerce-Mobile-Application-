import 'package:flutter/material.dart';
import 'package:flutter_application/screens/cart.dart';
import 'package:flutter_application/screens/search.dart';
import 'package:flutter_application/screens/stipe_payment.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/state/user_state.dart';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:flutter_application/widgets/single_category.dart';
import 'package:flutter_application/widgets/single_product.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    if (!_isLoading) {
      return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('HomeScreen'),
        ),
        body: const Center(child: Text('No data found..')),
      );
    } else {
      return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('HomeScreen'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                },
                icon: const Icon(Icons.search)),
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
        body: Column(
          children: [
            SizedBox(
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, i) =>
                      SingleCategory(category: category[i])),
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
            SizedBox(height: 10),
          ],
        ),
      );
    }
  }
}
