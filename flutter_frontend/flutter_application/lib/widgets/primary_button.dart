import 'package:flutter/material.dart';
import 'package:flutter_application/theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.buttonText}) : super(key: key);
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
        child: Center(
          child: Text(
            buttonText,
            style: textButton.copyWith(color: kWhiteColor),
          ),
        ));
  }
}
