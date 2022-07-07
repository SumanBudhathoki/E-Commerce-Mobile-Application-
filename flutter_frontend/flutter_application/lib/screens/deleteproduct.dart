// import 'dart:convert';
import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/screens/home.dart';
import 'package:flutter_application/screens/homepage.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/widgets/app_drawer-seller.dart';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../state/user_state.dart';

class DeleteProductScreen extends StatefulWidget {
  static const routeName = '/delete-product';
  const DeleteProductScreen({Key? key}) : super(key: key);

  @override
  State<DeleteProductScreen> createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  int? _productId;
  bool showSpinner = false;
  final _form = GlobalKey<FormState>();

  late File selectedImage;
  var resJson;

  onUploadImage() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      showSpinner = true;
    });
    var request = http.MultipartRequest(
      'DELETE',
      Uri.parse("http://10.0.2.2:8000/api/update-post/$_productId/"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    setState(() {
      resJson = jsonDecode(response.body);
    });
    if (response.statusCode == 200) {
      print("Image uploaded");
      setState(() {
        showSpinner = false;
      });
    } else {
      setState(() {
        showSpinner = false;
      });
      print("Image not uploaded");
    }
  }

  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image!.path);
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      selectedImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context)!.settings.arguments;
    _productId = productid as int?;
    final userId = (Provider.of<UserState>(context).getId()).toString();

    // userId1 = userId.toString();
    final category = Provider.of<ProductState>(context).category;
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Page"),
      ),
      drawer: AppDrawerSeller(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('Are you sure you want to delete?'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('CONFIRM'),
                      onPressed: () {
                        onUploadImage();
                        // Provider.of<ProductState>(context, listen: false)
                        //     .deleteProduct(productid);
                        Navigator.of(context).pushNamed(HomePage.routeName);
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(HomePage.routeName);
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //     ElevatedButton(
    //         onPressed: () {
    //           onUploadImage();
    //           Navigator.of(context).pushNamed(HomeScreen.routeName);
    //           // _postAds();
    //           // print(category[0].title);
    //         },
    //         child: Text("Submit")),
    //   ),
    // );
  }
}
