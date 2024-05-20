import 'package:flutter/material.dart';

abstract class AuthService {
  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> logOut();
  Future<void> signInWithGoogle(BuildContext context);
}
