import 'package:flutter/material.dart';
import 'package:flutter_application/theme.dart';

class CheckBox extends StatefulWidget {
  final String text;
  const CheckBox({Key? key, required this.text}) : super(key: key);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
              child: Container(
                child: _isSelected
                    ? const Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.green,
                      )
                    : null,
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kDarkGreyColor)),
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            Text(widget.text),
          ],
        )
      ],
    );
  }
}
