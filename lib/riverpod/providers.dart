import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/authentication/auth_service_implementation.dart';
import 'package:zoom/riverpod/auth_notifier.dart';

final authServiceProvider = Provider(
  (ref) {
    return AuthServiceImplementation();
  },
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) {
    return AuthNotifier(
      ref.watch(authServiceProvider),
    );
  },
);

final authStateProvider = StreamProvider((ref) {
  final authState = ref.watch(authNotifierProvider.notifier);

  return authState.authStateChange;
});
