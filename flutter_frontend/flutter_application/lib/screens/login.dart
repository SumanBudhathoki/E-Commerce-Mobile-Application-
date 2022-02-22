import 'package:flutter/material.dart';
import 'package:flutter_application/screens/register.dart';
import 'package:flutter_application/screens/reset_password.dart';
import 'package:flutter_application/widgets/primary_button.dart';
import 'package:flutter_application/theme.dart';
import '../widgets/login_form.dart';
import '../widgets/login_option.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                height: 40,
              ),
              const SizedBox(
                height: 100,
                child: Center(
                    child: Image(
                  image: AssetImage('assets/logo.png'),
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                )),
              ),
              const SizedBox(
                height: 60,
              ),
              Text('Welcome Back', style: sTitleText),
              const SizedBox(height: 5),
              const LoginForm(),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordReset()));
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: kZambeziColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const PrimaryButton(
                buttonText: 'Log in',
              ),
              const SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('New to this app? ', style: subTitle),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: textButton.copyWith(
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 40),
              Text(
                'Or Log in with:',
                style: subTitle.copyWith(color: kPrimaryColor),
              ),
              const SizedBox(height: 25),
              const LoginOption(),
            ],
          ),
        ),
      )),
    );
  }
}
