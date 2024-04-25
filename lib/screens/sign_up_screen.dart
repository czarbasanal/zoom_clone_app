import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom/utils/colors.dart';
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
  bool _isLoading = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    bool isButtonEnabled =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    if (isButtonEnabled != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isButtonEnabled;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUpWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    final authService = AuthService();
    try {
      final userCredential = await authService.signUpWithEmailPassword(
        emailController.text,
        passwordController.text,
      );

      if (userCredential != null) {
        Navigator.of(context).pushReplacementNamed('/sign_in');
      } else {
        // Handle errors here
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF6E6E6E),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                        controller: emailController,
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
                      controller: passwordController,
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
                    ),
                    Divider(
                      height: 0,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF6E6E6E),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                      obscureText: true,
                    ),
                  ],
                ),
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
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF6E6E6E),
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
              const SizedBox(height: 12),
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
    );
  }
}
