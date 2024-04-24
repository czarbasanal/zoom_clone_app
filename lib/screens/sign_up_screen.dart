import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/apple_button.dart';
import 'package:zoom/widgets/facebook_button.dart';
import 'package:zoom/widgets/final_sign_up.dart';
import 'package:zoom/widgets/google_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
          title: const Text('Sign Up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF0094FF),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
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
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
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
                  SizedBox(height: 25),
                  Center(
                    child: FinalSignUp(
                      text: 'Continue',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    '''By proceeding, I agree to the Zoom's Privacy Statement and Terms of Service''',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF1e1d25),
                    ),
                  ),
                  SizedBox(height: 50),
                  const Text(
                    'OR SELECT YOUR SIGN UP METHOD',
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
      ),
    );
  }
}
