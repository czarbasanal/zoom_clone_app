import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthService {
  Future<void> signUp(String email, String password, WidgetRef ref);
  Future<void> signIn(
      String email, String password, WidgetRef ref, BuildContext context);
  Future<void> logOut(WidgetRef ref);
  Future<void> signInWithGoogle(BuildContext context, WidgetRef ref);
}
