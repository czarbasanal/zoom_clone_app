import 'package:flutter/material.dart';
import 'package:zoom/screens/sign_up_screen.dart';
import 'package:zoom/utils/colors.dart';

class SignUp extends StatelessWidget {
  final String text;
  const SignUp({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {

         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
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
          borderRadius:
              BorderRadius.circular(10.0), // Adjust border radius as needed
        ),
      ),
    );
  }
}
