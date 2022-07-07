// import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/screens/homepage.dart';
import 'package:flutter_application/state/product_state.dart';
import 'package:flutter_application/widgets/app_drawer-seller.dart';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../state/user_state.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? _title;
  String? _price;
  String? _description;
  String? _catagory;
  File? image;
  String? _userId;
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
      'POST',
      Uri.parse("http://10.0.2.2:8000/api/addproducts/"),
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
      print("Image uploadded");
      setState(() {
        showSpinner = false;
      });
    } else {
      setState(() {
        showSpinner = false;
      });
      print("Image not uploadede");
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

  void _postAds() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    var order = await Provider.of<ProductState>(context, listen: false)
        .postads(_title, _price, _description, _catagory, image);
    if (order) {
      Navigator.of(context).pushNamed(HomePage.routeName);
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      var choosedimage = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final XFile imgTemp = XFile(image.path);
      setState(() {
        image = choosedimage as File?;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = (Provider.of<UserState>(context).getId()).toString();
    print(userId);
    // userId1 = userId.toString();
    final category = Provider.of<ProductState>(context).category;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Product"),
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
