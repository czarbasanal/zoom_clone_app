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
    final messages = ref.watch(messagesProvider(contact.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message.message),
                  subtitle: Text(message.timestamp.toString()),
                  trailing: message.senderId == ref.read(userProvider)?.id
                      ? Icon(Icons.person)
                      : null,
                );
              },
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
                        print("MESSAGE SENT " + text);
                        ref
                            .read(messagesProvider(contact.id).notifier)
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
                      print("MESSAGE SENT " + text);
                      ref
                          .read(messagesProvider(contact.id).notifier)
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
}