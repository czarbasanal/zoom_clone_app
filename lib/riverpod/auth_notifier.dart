import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/authentication/auth_service_implementation.dart';

class AuthNotifier extends StateNotifier<bool> {
  final AuthServiceImplementation _authServiceImplementation;

  AuthNotifier(
    this._authServiceImplementation,
  ) : super(false);

  Stream<User?> get authStateChange => _authServiceImplementation.userState;

  Future<void> googleSignIn(BuildContext context) async {
    state = false;
    await _authServiceImplementation.signInWithGoogle(context);
    state = true;
  }

  Future<void> logOut() async {
    state = false;
    await _authServiceImplementation.logOut();
    state = true;
  }

  Future<void> signIn(String email, String password) async {
    state = false;
    await _authServiceImplementation.signIn(email, password);
    state = true;
  }

  Future<void> signUp(String email, String password) async {
    state = false;
    await _authServiceImplementation.signUp(email, password);
    state = true;
  }
}
