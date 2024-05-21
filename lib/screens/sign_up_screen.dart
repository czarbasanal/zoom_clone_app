import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/riverpod/providers.dart';
import 'package:zoom/widgets/final_sign_up.dart';
import 'package:zoom/widgets/google_button.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  bool _isLoading = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailEditingController.addListener(_validateForm);
    passwordEditingController.addListener(_validateForm);
  }

  void _validateForm() {
    bool isButtonEnabled = emailEditingController.text.isNotEmpty &&
        passwordEditingController.text.isNotEmpty;
    if (isButtonEnabled != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isButtonEnabled;
      });
    }
  }

  @override
  void dispose() {
    emailEditingController.removeListener(_validateForm);
    passwordEditingController.removeListener(_validateForm);
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_isButtonEnabled) {
      _signUp(context, ref);
    }
  }

  void _signUp(BuildContext context, WidgetRef ref) async {
    setState(() {
      _isLoading = true;
    });
    final signUpState = ref.read(authNotifierProvider.notifier);
    try {
      await signUpState.signUp(
        emailEditingController.text,
        passwordEditingController.text,
        ref,
      );
      Navigator.pushNamed(context, '/sign_in');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
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
        body: Stack(
          children: [
            SingleChildScrollView(
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
                              controller: emailEditingController,
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
                            controller: passwordEditingController,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: FinalSignUp(
                        text: 'Continue',
                        onPressed: _handleSignUp,
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
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          final signUpState =
                              ref.read(authNotifierProvider.notifier);

                          try {
                            await signUpState.googleSignIn(context, ref);
                            Navigator.pushNamed(context, '/meetings');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to sign up: $e')),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
