import 'dart:convert';
import 'dart:io';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String? text;
  File? image;
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
      Uri.parse("http://10.0.2.2:8000/api/addimage/"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.fields['title'] = text!;
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

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
        ),
        drawer: AppDrawer(),
        body: Form(
          key: _form,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    text = v;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    child: image == null
                        ? Center(
                            child: Text('Pick Image'),
                          )
                        : Container(
                            child: Center(
                              child: Image.file(
                                File(image!.path).absolute,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 150),
                GestureDetector(
                  onTap: () {
                    onUploadImage();
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    color: Colors.green,
                    child: Center(child: Text('Upload')),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}








 // Future<void> uploadImage() async {
  //   setState(() {
  //     showSpinner = true;
  //   });

  //   var stream = http.ByteStream(image!.openRead());
  //   stream.cast();
  //   var length = await image!.length();

  //   var url = Uri.parse('http://10.0.2.2:8000/api/addimage/');

  //   var request = http.MultipartRequest('post', url);

  //   var multiport = http.MultipartFile('image', stream, length);

  //   request.files.add(multiport);
  //   var response = await request.send();
  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     print("Image uploadded");
  //     setState(() {
  //       showSpinner = false;
  //     });
  //   } else {
  //     setState(() {
  //       showSpinner = false;
  //     });
  //     print("Image not uploadede");
  //   }
  // }

  
  // Future getImage() async {
  //   final pickedFile =
  //       await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //     setState(() {});
  //   } else {
  //     print("No image selected");
  //   }
  // }