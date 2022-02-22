import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login.dart';
import 'package:flutter_application/theme.dart';
import 'package:flutter_application/widgets/checkbox.dart';
import 'package:flutter_application/widgets/login_option.dart';
import 'package:flutter_application/widgets/primary_button.dart';
import 'package:flutter_application/widgets/register_form.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/register-screen';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: kDefaultPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Create Account',
                  style: sTitleText,
                ),
                const SizedBox(
                  height: 20,
                ),
                const RegisterForm(),
                const SizedBox(
                  height: 20,
                ),
                const CheckBox(text: 'Agree to all the terms and condition'),
                const SizedBox(height: 30),
                const PrimaryButton(buttonText: 'Create Account'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: subTitle,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Text(
                        'Sign In',
                        style: textButton.copyWith(
                            decoration: TextDecoration.underline,
                            decorationThickness: 1),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'Or Register With',
                  style: subTitle.copyWith(color: kPrimaryColor),
                ),
                const SizedBox(height: 25),
                const LoginOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
