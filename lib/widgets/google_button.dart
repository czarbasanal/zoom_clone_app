import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';

class GoogleSignIn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const GoogleSignIn({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: primaryWhite,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google_icon.png',
              width: 24,
              height: 24,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(fontSize: 17, color: Color(0xFF1e1d25)),
            ),
          ],
        ),
      ),
    );
  }
}
