import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:zoom/riverpod/providers.dart';
import '../models/user.dart' as custom_user;
import '../authentication/auth_service_implementation.dart';

class UserNotifier extends StateNotifier<custom_user.User?> {
  UserNotifier() : super(null);

  void setUser(custom_user.User user) {
    state = user;
    print('User set: ${user.email}');
  }

  void clearUser() {
    state = null;
    print('User cleared');
  }

  Stream<firebase_auth.User?> get authStateChange =>
      AuthServiceImplementation().userState;
}

class AuthNotifier extends StateNotifier<bool> {
  final AuthServiceImplementation _authService;

  AuthNotifier(this._authService) : super(false);

  Stream<firebase_auth.User?> get authStateChange => _authService.userState;

  Future<void> signOut(WidgetRef ref) async {
    await _authService.logOut(ref);
    state = false;
    ref.invalidate(userProvider);
    ref.invalidate(userProvider);
    ref.invalidate(contactsProvider);
    ref.invalidate(conversationsProvider);
    ref.read(contactsProvider.notifier).reset();
    ref.read(conversationsProvider.notifier).reset();
  }

  Future<void> signIn(String email, String password, WidgetRef ref) async {
    await _authService.signIn(email, password, ref);
    state = true;
  }

  Future<void> googleSignIn(BuildContext context, WidgetRef ref) async {
    await _authService.signInWithGoogle(context, ref);
    state = true;
  }

  Future<void> signUp(String email, String password, WidgetRef ref) async {
    await _authService.signUp(email, password, ref);
    state = true;
  }
}
