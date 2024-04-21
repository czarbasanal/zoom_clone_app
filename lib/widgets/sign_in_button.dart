import 'package:flutter/material.dart';
import 'package:zoom/screens/sign_in_screen.dart';
import 'package:zoom/utils/colors.dart';

class SignIn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SignIn({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to SignInScreen when the button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 17, color: Color(0XFF1e1d25)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryWhite,
        minimumSize: const Size(350, 50),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
