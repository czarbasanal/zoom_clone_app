import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const LogoutButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(14, 114, 236, 1),
          minimumSize: const Size(
            double.infinity,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color.fromRGBO(14, 114, 236, 1)),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, color: Color(0XFFFFFFFF)),
        ),
      ),
    );
  }
}
