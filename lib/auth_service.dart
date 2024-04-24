import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    await user?.sendEmailVerification();
    return user;
  }

  // Check if the user's email is verified
  Future<bool> isEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
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
