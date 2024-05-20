import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/bottom_rounded_container.dart';
import 'package:zoom/widgets/custom_button.dart';
import 'package:zoom/widgets/sign_in_button.dart';
import 'package:zoom/widgets/sign_up_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        scaffoldBackgroundColor: primaryBlue,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            const BottomRoundedContainer(
              height: 350.0,
              color: Colors.white,
              borderRadius: 24.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 300),
                        Image.asset(
                          'assets/images/zoom_white_logo.png',
                          width: 140,
                        ),
                        const SizedBox(height: 215),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
