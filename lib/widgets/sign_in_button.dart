import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';

class SignIn extends StatelessWidget {
  final String text;

  const SignIn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/sign_in'),
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryWhite,
        minimumSize: const Size(350, 50),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18,
            color: Color(0XFF1e1d25),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
