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

class UpdateProductScreen extends StatefulWidget {
  static const routeName = '/update-product';
  const UpdateProductScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  String? _title;
  String? _price;
  String? _description;
  String? _catagory;
  File? image;
  String? _userId;
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
      'PUT',
      Uri.parse("http://10.0.2.2:8000/api/update-post/$_productId/"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.fields['title'] = _title!;
    request.fields['selling_price'] = _price!;
    request.fields['description'] = _description!;
    request.fields['category'] = _catagory!;
    request.fields['user'] = _userId!;

    request.files.add(
      http.MultipartFile(
        'image',
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: selectedImage.path.split('/').last,
      ),
    );
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
        title: Text("Update"),
      ),
      drawer: AppDrawerSeller(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Title"),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter the title";
                  }
                  return null;
                },
                onSaved: (v) {
                  _title = v!;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              // DropdownButton<String>(
              //   hint: Text("Select Category"),
              //   value: catvalue,
              //   isExpanded: true,
              //   elevation: 16,
              //   style: TextStyle(color: Colors.grey[800]),
              //   underline: Container(
              //     height: 1,
              //     color: Colors.grey,
              //   ),
              //   icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              //   items: category.map(buildMenuItem),
              //   onChanged: (String? value) {
              //     setState(() {
              //       catvalue = value;
              //       print(value);
              //     });
              //   },
              // ),
              TextFormField(
                decoration: InputDecoration(hintText: "Catagory"),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter the price";
                  }
                  return null;
                },
                onSaved: (v) {
                  _catagory = v;
                },
              ),

              TextFormField(
                decoration: InputDecoration(hintText: "$userId"),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter the userID";
                  }
                  return null;
                },
                onSaved: (v) {
                  _userId = v!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Price"),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter the price";
                  }
                  return null;
                },
                onSaved: (v) {
                  _price = v;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 1, //Normal textInputField will be displayed
                maxLines: 5, // when user presses enter it will adapt to it
                decoration: InputDecoration(hintText: "Description"),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter the description for product";
                  }
                  return null;
                },
                onSaved: (v) {
                  _description = v;
                },
              ),

              const SizedBox(height: 10),
              // ElevatedButton.icon(
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: Size.fromHeight(56),
              //     primary: Colors.white,
              //     onPrimary: Colors.black,
              //     textStyle: TextStyle(fontSize: 16),
              //   ),
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) => const AlertDialog(
              //         title: Text("Choose your option"),
              //         actions: <Widget>[
              //           OptionImgPicker(),
              //         ],
              //       ),
              //     );
              //   },
              //   icon: Icon(Icons.image),
              //   label: Text('Select picture'),
              // ),
              const Text("Select picture from"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Gallery'),
                    onPressed: () {
                      // pickImage(ImageSource.gallery);
                      getImage();
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    onPressed: () {
                      getImageCamera();
                      // pickImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    onUploadImage();
                    Navigator.of(context).pushNamed(HomePage.routeName);
                    // _postAds();
                    // print(category[0].title);
                  },
                  child: Text("Submit"))
            ],
          ),
        )),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 16),
        ),
      );
}
