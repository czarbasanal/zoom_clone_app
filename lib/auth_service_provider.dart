import 'package:riverpod/riverpod.dart';
import 'package:zoom/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
