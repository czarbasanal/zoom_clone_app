import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom/models/message.dart';
import 'providers.dart';

class MessagesNotifier extends StateNotifier<List<Message>> {
  final Ref ref;
  final String conversationId;

  MessagesNotifier(this.ref, this.conversationId) : super([]);

  Future<void> loadMessages() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(ref.read(userProvider)?.id)
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp')
        .get();
    state = snapshot.docs
        .map((doc) => Message.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> sendMessage(String message) async {
    final userId = ref.read(userProvider)?.id;
    if (userId != null) {
      final timestamp = DateTime.now();
      final docRef = FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(ref.read(userProvider)?.id)
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .doc();
      final newMessage = Message(
        id: docRef.id,
        senderId: userId,
        message: message,
        timestamp: timestamp,
      );
      await docRef.set(newMessage.toMap());
      state = [...state, newMessage];
    }
  }
}
