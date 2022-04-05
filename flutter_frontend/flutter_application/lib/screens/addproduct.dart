// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:flutter_application/widgets/img_chooseoption.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? _title;
  String? _price;
  String? _desc;
  final category = ['Category 1', 'Category 2'];
  String? catvalue;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Product"),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Form(
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
              DropdownButton<String>(
                hint: Text("Select Category"),
                value: catvalue,
                isExpanded: true,
                elevation: 16,
                style: TextStyle(color: Colors.grey[800]),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                items: category.map(buildMenuItem).toList(),
                onChanged: (String? value) {
                  setState(() {
                    catvalue = value;
                    print(value);
                  });
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
                  _desc = v;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(56),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                      title: Text("Choose your option"),
                      actions: <Widget>[
                        OptionImgPicker(),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.image),
                label: Text('Select picture'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    // _postNow();
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
