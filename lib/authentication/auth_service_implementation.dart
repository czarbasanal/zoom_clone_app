import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom/authentication/auth_service.dart';

class AuthServiceImplementation implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//getter Method for excessing the current user so that we can display the essential info in our meeting Screen or while integrating Jitsi.
  User get user => _firebaseAuth.currentUser!;

  // we will be using this for persisting state later on using some provider.
  Stream<User?> get userState => _firebaseAuth.authStateChanges();

  @override
  Future<void> googleSignIn() async {
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
          await _firebaseFirestore
              .collection('UserCollection')
              .doc(user.uid)
              .set({
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      e.message.toString();
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
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      e.message.toString();
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firebaseFirestore.collection('Users').doc(user.uid).set({
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      e.message.toString();
    }
  }
}
