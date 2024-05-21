import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zoom/authentication/auth_service_implementation.dart';
import 'package:zoom/riverpod/auth_notifier.dart';
import 'package:zoom/riverpod/contacts_notifier.dart' as contacts;
import 'package:zoom/riverpod/conversations_notifier.dart';
import 'package:zoom/riverpod/messages_notifier.dart' as messages;
import '../models/user.dart' as custom_user;
import 'package:zoom/models/contact.dart';
import 'package:zoom/models/conversation.dart';
import 'package:zoom/models/message.dart';

final userProvider = StateNotifierProvider<UserNotifier, custom_user.User?>(
    (ref) => UserNotifier());

final contactsProvider =
    StateNotifierProvider<contacts.ContactsNotifier, List<Contact>>(
        (ref) => contacts.ContactsNotifier(ref));
final contactsStreamProvider = StreamProvider<void>((ref) {
  return ref.watch(contactsProvider.notifier).loadContacts();
});

final conversationsProvider =
    StateNotifierProvider<ConversationsNotifier, List<Conversation>>(
        (ref) => ConversationsNotifier(ref));

final messagesProvider = StateNotifierProvider.family<messages.MessagesNotifier,
        List<Message>, String>(
    (ref, conversationId) => messages.MessagesNotifier(ref, conversationId));
final messagesStreamProvider =
    StreamProvider.family<void, String>((ref, conversationId) {
  return ref.watch(messagesProvider(conversationId).notifier).loadMessages();
});

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

final loadingProvider = StateProvider<bool>((ref) => false);
final videoOnProvider = StateProvider<bool>((ref) => false);
final audioOnProvider = StateProvider<bool>((ref) => false);
