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
        scaffoldBackgroundColor: primaryBlue, // Set scaffold background color
      ),
      child: Scaffold(
        body: Stack(
          children: [
            BottomRoundedContainer(
              height: 350.0,
              color: Colors.white,
              borderRadius: 20.0,
              child:
                  SizedBox(), // Empty SizedBox as we don't need content inside this container
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 200),
                        Image.asset(
                          'assets/images/zoom_white_logo.png',
                        ),
                        SizedBox(height: 300),
                        const Text(
                          'Welcome',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF1e1d25)),
                        ),
                        SizedBox(height: 5),
                        const Text(
                          'Get started with your account',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF1e1d25)),
                        ),
                        SizedBox(height: 20),
                        CustomButton(text: 'Join a Meeting'),
                        SizedBox(height: 20),
                        SignUp(text: 'Sign up'),
                        SizedBox(height: 20),
                        SignIn(
                          text: 'Sign in',
                          onPressed: () {},
                        ),
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
