import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';

class FinalSignIn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const FinalSignIn({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 17,
            color: Color(0xFF8A8A8A),
            fontWeight: FontWeight.bold),
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
