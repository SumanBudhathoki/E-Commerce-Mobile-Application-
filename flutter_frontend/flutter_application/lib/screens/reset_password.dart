import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login.dart';
import 'package:flutter_application/theme.dart';
import 'package:flutter_application/widgets/primary_button.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reset Password',
                style: sTitleText,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Enter your registered email address',
                style: subTitle,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                  labelStyle: TextStyle(color: kTextFieldColor),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: PrimaryButton(buttonText: 'Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
