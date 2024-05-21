import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/contact.dart';
import '../models/message.dart';
import '../riverpod/providers.dart';

class ChatScreen extends ConsumerWidget {
  final Contact contact;
  final TextEditingController _messageController = TextEditingController();

  ChatScreen({required this.contact});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    if (user == null) {
      return Scaffold(
        body: Center(child: Text('User not found')),
      );
    }

    final conversationId = _createConversationId(user.id, contact.id);
    final messagesStream = ref.watch(messagesStreamProvider(conversationId));

    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesStream.when(
              data: (_) {
                final messages = ref.watch(messagesProvider(conversationId));

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Text(message.message),
                      subtitle: Text(message.timestamp.toString()),
                      trailing: message.senderId == user.id
                          ? Icon(Icons.person)
                          : null,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error loading messages')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        ref
                            .read(messagesProvider(conversationId).notifier)
                            .sendMessage(text);
                        _messageController.clear();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = _messageController.text;
                    if (text.isNotEmpty) {
                      ref
                          .read(messagesProvider(conversationId).notifier)
                          .sendMessage(text);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _createConversationId(String userId1, String userId2) {
    // Ensure consistent conversation ID order
    return userId1.compareTo(userId2) < 0
        ? '$userId1-$userId2'
        : '$userId2-$userId1';
  }
}
