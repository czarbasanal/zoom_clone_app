import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MailScreen extends StatelessWidget {
  const MailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Image.asset(
            'assets/mail.jpg',
            width: 600,
            height: 600,
          )
        ],
      ),
    );
  }
}
