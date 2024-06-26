import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18,
            color: Color(0XFFFFFFFF),
            fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        minimumSize: const Size(350, 50),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
