import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/bottom_rounded_container.dart';
import 'package:zoom/widgets/custom_button.dart';
import 'package:zoom/widgets/sign_in_button.dart';
import 'package:zoom/widgets/sign_up_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                        const SizedBox(height: 250),
                        Image.asset(
                          'assets/images/zoom_white_logo.png',
                          width: 140,
                        ),
                        const SizedBox(height: 200),
                        const Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF1e1d25)),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Get started with your account',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0XFF1e1d25)),
                        ),
                        const SizedBox(height: 30),
                        CustomButton(text: 'Join a meeting'),
                        SizedBox(height: 14),
                        SignUp(text: 'Sign up'),
                        SizedBox(height: 14),
                        SignIn(text: 'Sign in'),
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
