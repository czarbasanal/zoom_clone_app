import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'auth_service_provider.dart';

class SignUpState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  SignUpState({this.isLoading = false, this.errorMessage, this.successMessage});
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  final Ref ref;

  SignUpNotifier(this.ref) : super(SignUpState());

  Future<void> sendSignInLinkToEmail(String email) async {
    try {
      state = SignUpState(isLoading: true);
      await ref.read(authServiceProvider).sendSignInLinkToEmail(email);
      state = SignUpState(
          successMessage: 'A verification link has been sent to $email.');
    } on FirebaseAuthException catch (e) {
      state = SignUpState(errorMessage: e.message);
    } catch (e) {
      state = SignUpState(errorMessage: e.toString());
    }
  }
}

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  return SignUpNotifier(ref.read);
});
