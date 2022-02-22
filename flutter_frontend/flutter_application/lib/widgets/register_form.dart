import 'package:flutter/material.dart';
import 'package:flutter_application/theme.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputField('Full Name', false),
        buildInputField('Email', false),
        buildInputField('Username', false),
        buildInputField('Phone Number', false),
        buildInputField('Password', true),
        buildInputField('Confirm Password', true),
      ],
    );
  }

  Padding buildInputField(String labelField, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
          labelText: labelField,
          labelStyle: const TextStyle(color: kTextFieldColor),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: _isObscure
                      ? const Icon(Icons.visibility_off, color: kDarkGreyColor)
                      : const Icon(
                          Icons.visibility,
                          color: kPrimaryColor,
                        ))
              : null,
        ),
      ),
    );
  }
}
