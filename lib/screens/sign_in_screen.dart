import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/apple_button.dart';
import 'package:zoom/widgets/facebook_button.dart';
import 'package:zoom/widgets/final_sign_in.dart';
import 'package:zoom/widgets/google_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        scaffoldBackgroundColor: tertiaryWhite,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: Color(0xFF1e1d25),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF0094FF),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                const Text(
                  'ENTER YOUR EMAIL ADDRESS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    isCollapsed: true,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xFF8A8A8A),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 165.0,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 3),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    isCollapsed: true,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xFF8A8A8A),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 150.0,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 35),
                Center(
                  child: FinalSignIn(
                    text: 'Sign in',
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0094FF),
                  ),
                ),
                SizedBox(height: 50),
                const Text(
                  'OTHER SIGN IN METHODS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: GoogleSignIn(
                    text: 'Continue with Google',
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: AppleSignIn(
                    text: 'Continue with Apple',
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: FacebookSignIn(
                    text: 'Continue with Facebook',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
