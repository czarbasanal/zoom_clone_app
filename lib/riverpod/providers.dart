import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/authentication/auth_service_implementation.dart';
import 'package:zoom/riverpod/auth_notifier.dart';
import 'contacts_notifier.dart';
import 'conversations_notifier.dart';
import 'messages_notifier.dart';
import '../models/user.dart' as custom_user;
import 'package:zoom/models/contact.dart';
import 'package:zoom/models/conversation.dart';
import 'package:zoom/models/message.dart';

final userProvider = StateNotifierProvider<UserNotifier, custom_user.User?>(
    (ref) => UserNotifier());

final contactsProvider = StateNotifierProvider<ContactsNotifier, List<Contact>>(
    (ref) => ContactsNotifier(ref));

final contactsStreamProvider = StreamProvider<void>((ref) {
  return ref.watch(contactsProvider.notifier).loadContacts();
});

final conversationsProvider =
    StateNotifierProvider<ConversationsNotifier, List<Conversation>>(
        (ref) => ConversationsNotifier(ref));
final messagesProvider =
    StateNotifierProvider.family<MessagesNotifier, List<Message>, String>(
        (ref, conversationId) => MessagesNotifier(ref, conversationId));

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
