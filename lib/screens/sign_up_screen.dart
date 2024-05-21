import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/riverpod/providers.dart';
import 'package:zoom/widgets/final_sign_up.dart';
import 'package:zoom/widgets/google_button.dart';
import 'package:zoom/widgets/main_bottom_navigation.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  Future<void> _signUp(
      BuildContext context, WidgetRef ref, bool isGoogle) async {
    ref.read(loadingProvider.notifier).state = true;

    try {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      if (isGoogle) {
        await authNotifier.googleSignIn(context, ref);
      } else {
        await authNotifier.signUp(
          emailEditingController.text,
          passwordEditingController.text,
          ref,
        );
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainBottomNavigation()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: $e')),
      );
    } finally {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final _isLoading = ref.watch(loadingProvider);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text('Sign up',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.chevron_left, size: 30),
            color: const Color(0xFF1072ED),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                    buildInputSection(),
                    const SizedBox(height: 20),
                    buildSignUpButton(),
                    const SizedBox(height: 20),
                    buildAgreementText(),
                    const SizedBox(height: 40),
                    buildOtherMethodsText(),
                    const SizedBox(height: 40),
                    buildGoogleSignUpButton(),
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
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget buildInputSection() {
    return Container(
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
                border: UnderlineInputBorder(borderSide: BorderSide.none)),
          ),
          Divider(height: 0, color: Colors.grey.withOpacity(0.2)),
          TextField(
            controller: passwordEditingController,
            textAlign: TextAlign.center,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF6E6E6E),
                ),
                border: UnderlineInputBorder(borderSide: BorderSide.none)),
          ),
        ],
      ),
    );
  }

  Widget buildSignUpButton() {
    return Center(
      child: FinalSignUp(
        text: 'Continue',
        onPressed: () => _signUp(context, ref, false),
      ),
    );
  }

  Widget buildAgreementText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'By proceeding, I agree to the Zoom\'s Privacy Statement and Terms of Service',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget buildOtherMethodsText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'OR SELECT YOUR SIGN UP METHOD',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFF6E6E6E),
        ),
      ),
    );
  }

  Widget buildGoogleSignUpButton() {
    return Center(
      child: GoogleSignIn(
        text: 'Continue with Google',
        onPressed: () => _signUp(context, ref, true),
      ),
    );
  }
}
