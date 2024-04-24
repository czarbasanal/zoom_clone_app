import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Function to handle user registration with Email and Password
  Future<UserCredential?> signUpWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for that email.');
      }
      return null;
    } catch (e) {
      // Handle other errors
      print(e);
      return null;
    }
  }

  // Function to handle user sign-in with Email and Password
  Future<UserCredential?> signInWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors here
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    } catch (e) {
      // Handle other errors
      print(e);
      return null;
    }
  }

  // Function to handle user sign-out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Function to get the current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Function to check if user is signed in
  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  // - Password reset
  // - Email verification
  // - OAuth with Google, Facebook, etc.
}
