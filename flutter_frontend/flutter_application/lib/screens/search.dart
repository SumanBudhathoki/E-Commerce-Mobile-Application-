import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/product_detail.dart';
import 'package:flutter_application/screens/search_service.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_search/services/search_service.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> searchResults = [];

  searchDjango(value) async {
    SearchService.searchDjangoApi(value).then((ResponseBody) {
      List<dynamic> data = jsonDecode(ResponseBody);
      setState(() {
        for (var element in data) {
          searchResults.add(element);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (val) {
                  searchResults.clear();
                  searchDjango(val);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 25),
                    hintText: 'Search hear',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    )),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return buildResultCard(searchResults[index]);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    int id = data['id'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: data['id'],
                );
              },
              title: Text(data['title']),
              subtitle: Text(data['selling_price'].toString()),
              leading: Image.network(
                data['image'],
              ),
              trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  showSnackBar(context);
                  Provider.of<CartState>(context, listen: false).addtoCart(id);
                  // showToast();
                },
              ),
            ),
            const Divider(color: Colors.black)
          ],
        );
      }),
    );
  }
}

void showSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text(
      'Item added successfully !',
      style: TextStyle(fontSize: 16),
    ),
    // action: SnackBarAction(
    //   label: "Undo",
    //   onPressed: () {},
    // ),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
