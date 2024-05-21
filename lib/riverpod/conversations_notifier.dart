import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom/models/conversation.dart';
import 'providers.dart';

class ConversationsNotifier extends StateNotifier<List<Conversation>> {
  final Ref ref;

  ConversationsNotifier(this.ref) : super([]);

  Future<void> loadConversations() async {
    final userId = ref.read(userProvider)?.id;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(userId)
          .collection('conversations')
          .get();
      state = snapshot.docs
          .map((doc) => Conversation.fromMap(doc.id, doc.data()))
          .toList();
    }
  }

  Future<void> startConversation(List<String> participants) async {
    final userId = ref.read(userProvider)?.id;
    if (userId != null) {
      final docRef = await FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(userId)
          .collection('conversations')
          .add({
        'participants': participants,
      });
      final conversation =
          Conversation(id: docRef.id, participants: participants);
      state = [...state, conversation];
    }
  }
}
