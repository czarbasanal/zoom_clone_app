import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom/models/message.dart';
import 'providers.dart';

class MessagesNotifier extends StateNotifier<List<Message>> {
  final Ref ref;
  final String conversationId;

  MessagesNotifier(this.ref, this.conversationId) : super([]);

  Stream<void> loadMessages() {
    final user = ref.read(userProvider);

    return FirebaseFirestore.instance
        .collection('UserCollection')
        .snapshots()
        .asyncMap((userSnapshot) async {
      final allMessages = <Message>[];

      for (var userDoc in userSnapshot.docs) {
        final userId = userDoc.id;
        final messagesSnapshot = await FirebaseFirestore.instance
            .collection('UserCollection')
            .doc(userId)
            .collection('conversations')
            .doc(conversationId)
            .collection('messages')
            .orderBy('timestamp')
            .get();

        final messages = messagesSnapshot.docs.map((doc) {
          return Message.fromMap(doc.id, doc.data());
        }).toList();

        allMessages.addAll(messages);
      }

      allMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      state = allMessages;
      print('Loaded messages: ${allMessages.length}');
    });
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

      final batch = FirebaseFirestore.instance.batch();

      final userCollectionSnapshot =
          await FirebaseFirestore.instance.collection('UserCollection').get();

      for (var userDoc in userCollectionSnapshot.docs) {
        final userId = userDoc.id;
        final messageRef = FirebaseFirestore.instance
            .collection('UserCollection')
            .doc(userId)
            .collection('conversations')
            .doc(conversationId)
            .collection('messages')
            .doc(messageId);

        batch.set(messageRef, message.toMap());
      }

      await batch.commit();

      print('Message sent: $text');
    } else {
      print('No user ID found');
    }
  }
}
