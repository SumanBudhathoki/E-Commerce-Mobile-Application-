import 'package:flutter/material.dart';
import 'package:flutter_application/screens/homescreen.dart';
import 'package:flutter_application/screens/register.dart';
import 'package:flutter_application/screens/reset_password.dart';
import 'package:flutter_application/state/user_state.dart';
import 'package:flutter_application/theme.dart';
import 'package:provider/provider.dart';
import '../widgets/login_option.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  late String _username;
  late String _password;

  void _loginNow() async {
    var isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    bool islogin = await Provider.of<UserState>(context, listen: false)
        .loginNow(_username, _password);
    if (!islogin) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
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
                      image: AssetImage(
                        'assets/logo.png',
                      ),
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Text('Welcome Back!', style: sTitleText),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Username",
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter your username';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _username = v!;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _password = v!;
                  },
                ),
                const SizedBox(
                  height: 10,
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
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _loginNow();
                  },
                  child: const PrimaryButton(
                    buttonText: 'Log in',
                  ),
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
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
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
              // Row(
              //   children: [
              //     RaisedButton(
              //       onPressed: () {
              //         _loginNow();
              //       },
              //       child: Text('Login'),
              //     )
              //   ],
              // )
            ),
          ),
        )),
      ),
    );
  }
}
