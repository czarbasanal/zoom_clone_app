import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/riverpod/providers.dart';
import 'package:zoom/widgets/final_sign_in.dart';
import 'package:zoom/widgets/google_button.dart';
import 'package:zoom/widgets/main_bottom_navigation.dart';

class SignInScreen extends StatefulHookConsumerWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Sign in',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_left, size: 30),
          color: const Color(0xFF1072ED),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              buildEmailPasswordInput(),
              SizedBox(height: 35),
              if (isLoading) const CircularProgressIndicator(),
              buildSignInButton(context),
              buildForgotPasswordButton(),
              buildOtherSignInMethodsLabel(),
              buildGoogleSignInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailPasswordInput() {
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
                  color: Color(0xFF6E6E6E)),
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
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
                  color: Color(0xFF6E6E6E)),
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInButton(BuildContext context) {
    return FinalSignIn(
      text: 'Sign in',
      onPressed: () {
        ref.read(loadingProvider.notifier).state = true;
        ref
            .read(authNotifierProvider.notifier)
            .signIn(emailEditingController.text, passwordEditingController.text,
                ref, context)
            .then((_) {
          ref.read(loadingProvider.notifier).state = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavigation()),
            (Route<dynamic> route) => false,
          );
        }).catchError((e) {
          ref.read(loadingProvider.notifier).state = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to sign in: $e')));
        });
      },
    );
  }

  Widget buildForgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: () {},
        child: const Text('Forgot password?',
            style: TextStyle(
                color: Color(0xFF1072ED), fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildOtherSignInMethodsLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'OTHER SIGN IN METHODS',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF6E6E6E)),
      ),
    );
  }

  Widget buildGoogleSignInButton(BuildContext context) {
    return GoogleSignIn(
      text: 'Continue with Google',
      onPressed: () {
        ref.read(loadingProvider.notifier).state = true;
        ref
            .read(authNotifierProvider.notifier)
            .googleSignIn(context, ref)
            .then((_) {
          ref.read(loadingProvider.notifier).state = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavigation()),
            (Route<dynamic> route) => false,
          );
        }).catchError((e) {
          ref.read(loadingProvider.notifier).state = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to sign in with Google: $e')));
        });
      },
    );
  }
}
