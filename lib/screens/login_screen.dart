import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/utils/screen_size.dart';
import 'package:zoom/widgets/bottom_rounded_container.dart';

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
            BottomRoundedContainer(
              height: screenHeight(context) * 0.38,
              color: Colors.white,
              borderRadius: screenWidth(context) * 0.055,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/zoom_new_logo_white.png',
                          width: screenWidth(context) * 0.7,
                        ),
                        SizedBox(height: screenHeight(context) * 0.22)
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
