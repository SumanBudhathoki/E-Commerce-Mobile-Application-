import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            print('Button Clicked with fb');
          },
          child: const BuildButton(
            iconImage: Image(
              height: 30,
              width: 30,
              image: AssetImage('assets/fb_png.png'),
            ),
            textButton: 'Facebook',
          ),
        ),
        InkWell(
          onTap: () {
            print('Button Clicked with google');
          },
          child: const BuildButton(
            iconImage: Image(
              height: 30,
              width: 30,
              image: AssetImage('assets/google_png.png'),
            ),
            textButton: 'Google',
          ),
        ),
      ],
    );
  }
}

class BuildButton extends StatelessWidget {
  final Image iconImage;
  final String textButton;

  const BuildButton({
    Key? key,
    required this.iconImage,
    required this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.06,
      width: mediaQuery.width * 0.36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconImage,
          const SizedBox(
            width: 5,
          ),
          Text(textButton),
        ],
      ),
    );
  }
}
