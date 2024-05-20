import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(),
            Image.asset(
              'assets/morePage1.jpg',
              // width: 810,
              height: 730,
            )
          ],
        ),
      ),
    );
  }
}
