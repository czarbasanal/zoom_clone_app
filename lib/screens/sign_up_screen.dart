import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/apple_button.dart';
import 'package:zoom/widgets/facebook_button.dart';
import 'package:zoom/widgets/final_sign_up.dart';
import 'package:zoom/widgets/google_button.dart';
import 'package:zoom/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUpWithEmailAndPassword() async {
    final authService = AuthService();
    final userCredential = await authService.signUpWithEmailPassword(
      emailController.text,
      passwordController.text,
    );

    if (userCredential != null) {
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      // TODO: Handle errors (ideally, in a user-friendly way such as showing an alert dialog)
    }
  }

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
          title: const Text('Sign up',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'ENTER YOUR EMAIL ADDRESS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFBDBDBD),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 56,
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
                  child: const TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF6E6E6E),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none))),
                ),
                const SizedBox(height: 20),
                Center(
                  child: FinalSignUp(
                    text: 'Continue',
                    onPressed: _signUpWithEmailAndPassword,
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'By proceeding, I agree to the Zoom\'s Privacy Statement and Terms of Service',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'OR SELECT YOUR SIGN UP METHOD',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFBDBDBD),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: GoogleSignIn(
                    text: 'Continue with Google',
                    onPressed: () {
                      // TODO: Implement Google sign-in functionality
                    },
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: FacebookSignIn(
                    text: 'Continue with Facebook',
                    onPressed: () {
                      // TODO: Implement Facebook sign-in functionality
                    },
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
