import 'package:flutter/material.dart';
import 'package:flutter_application/state/user_state.dart';
import 'package:flutter_application/theme.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/user-profile';
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context).getUserInfo;
    print(user);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('User Profile'),
        foregroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              radius: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/suman.jpg',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
