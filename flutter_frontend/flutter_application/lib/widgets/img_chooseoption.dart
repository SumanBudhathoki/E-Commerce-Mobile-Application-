import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class OptionImgPicker extends StatefulWidget {
  const OptionImgPicker({Key? key}) : super(key: key);

  @override
  State<OptionImgPicker> createState() => _OptionImgPickerState();
}

class _OptionImgPickerState extends State<OptionImgPicker> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imgTemp = File(image.path);
      setState(() {
        this.image = imgTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        buildButton(
          icon: Icons.image_outlined,
          onClicked: () {
            pickImage(ImageSource.gallery);
          },
          title: 'Pick Gallery',
        ),
        const SizedBox(
          height: 10,
        ),
        buildButton(
            title: 'Camera',
            icon: Icons.camera_alt_outlined,
            onClicked: () {
              pickImage(ImageSource.camera);
            }),
        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
          ],
        )
      ]),
    );
  }
}

class buildButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClicked;
  const buildButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(56),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 16),
        ),
        onPressed: onClicked,
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(
              width: 16,
            ),
            Text(title)
          ],
        ));
  }
}
