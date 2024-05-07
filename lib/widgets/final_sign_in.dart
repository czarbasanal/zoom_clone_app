import 'package:flutter/material.dart';

class FinalSignIn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const FinalSignIn({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1072ED),
        minimumSize: const Size(350, 50),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16.0), // Adjust border radius as needed
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
