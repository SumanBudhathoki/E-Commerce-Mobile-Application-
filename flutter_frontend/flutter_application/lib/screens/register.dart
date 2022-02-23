import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login.dart';
import 'package:flutter_application/state/user_state.dart';
import 'package:flutter_application/theme.dart';
import 'package:flutter_application/widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../widgets/checkbox.dart';
import '../widgets/login_option.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'register-screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _password;
  late String _confirmPassword;

  void _registerNow() async {
    var isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    bool isRegister = await Provider.of<UserState>(context, listen: false)
        .registerNow(_username, _confirmPassword, _email);
    if (isRegister == true) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Something is wrong! Try again."),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back'),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: kDefaultPadding,
          child: Form(
            key: _form,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter a username';
                  }
                  return null;
                },
                onSaved: (v) {
                  _username = v!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter a email';
                  }
                  return null;
                },
                onSaved: (v) {
                  _email = v!;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter a password';
                  }
                  return null;
                },
                onChanged: (v) {
                  setState(() {
                    _password = v;
                  });
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter a confirmation password';
                  }
                  if (_password != v) {
                    return 'Confirmation password does not match!';
                  }
                  return null;
                },
                onSaved: (v) {
                  _confirmPassword = v!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const CheckBox(text: 'Agree to all the terms and condition'),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _registerNow();
                },
                child: const PrimaryButton(buttonText: 'Create Account'),
              ),
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
                      'Log in',
                      style: textButton.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 60),
              Text(
                'Or Register With',
                style: subTitle.copyWith(color: kPrimaryColor),
              ),
              const SizedBox(height: 25),
              const LoginOption(),
            ]),
          ),
        )),
      ),
    );
  }
}
