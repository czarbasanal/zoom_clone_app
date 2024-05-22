import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom/riverpod/providers.dart';
import '../models/message.dart';

class MessagesNotifier extends StateNotifier<List<Message>> {
  final Ref ref;
  final String conversationId;
  late final Stream<List<Message>> messagesStream;

  MessagesNotifier(this.ref, this.conversationId) : super([]) {
    _loadMessages();
    messagesStream = _initializeMessagesStream();
  }

  Stream<List<Message>> _initializeMessagesStream() {
    final user = ref.read(userProvider);
    if (user == null) {
      print('User not found');
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(user.id)
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      final messages = snapshot.docs.map((doc) {
        return Message.fromMap(doc.id, doc.data());
      }).toList();

      state = messages;
      print('Messages updated: ${messages.length}');
      return messages;
    });
  }

  Stream<List<Message>> _loadMessages() {
    final user = ref.read(userProvider);
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(user.id)
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('timestamp')
          .snapshots()
          .map((snapshot) {
        final messages = snapshot.docs.map((doc) {
          return Message.fromMap(doc.id, doc.data());
        }).toList();
        state = messages; // Update state on each change.
        return messages;
      });
    } else {
      // Optionally handle the case where the user is not found.
      return Stream.value([]);
    }
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(userProvider);
    if (user != null) {
      final messageId =
          FirebaseFirestore.instance.collection('UserCollection').doc().id;
      final message = Message(
        id: messageId,
        senderId: user.id,
        message: text,
        timestamp: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(user.id)
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());

      print('Message sent: $text');
    } else {
      print('No user ID found');
    }
  }
}
