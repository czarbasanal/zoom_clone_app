import 'package:flutter/cupertino.dart';
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
          title: const Text('Sign in',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                CupertinoIcons.chevron_left,
                size: 30,
              ),
              color: const Color(0xFF1072ED),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'ENTER YOUR EMAIL ADDRESS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF6E6E6E),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 0.75,
                      blurRadius: 0.5,
                      offset: const Offset(1, 0.25),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF6E6E6E),
                            ),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none))),
                    Divider(
                      height: 0,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF6E6E6E),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                      obscureText: true,
                    )
                  ],
                ),
              ),
              SizedBox(height: 35),
              Center(
                child: FinalSignIn(
                  text: 'Sign in',
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password?',
                        style: TextStyle(
                            color: Color(0xFF1072ED),
                            fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'OTHER SIGN IN METHODS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF6E6E6E),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: GoogleSignIn(
                  text: 'Continue with Google',
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 12),
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
    );
  }
}
