import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom/authentication/auth_service.dart';
import 'package:zoom/utils/utils.dart';
import 'dart:math';

class AuthServiceImplementation implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<User?> get userState => _firebaseAuth.authStateChanges();
  User get user => _firebaseAuth.currentUser!;

  @override
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(authCredential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          String pmi = _generatePMI();
          await _firebaseFirestore
              .collection('UserCollection')
              .doc(user.uid)
              .set({
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'pmi': pmi,
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      e.message.toString();
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          String pmi = _generatePMI();
          await _firebaseFirestore
              .collection('UserCollection')
              .doc(user.uid)
              .set({
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'pmi': pmi,
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      e.message.toString();
    }
  }

  String _generatePMI() {
    return (Random().nextInt(90000000) + 10000000)
        .toString(); // Generates an 8-digit PMI
  }
}
