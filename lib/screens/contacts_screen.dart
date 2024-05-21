import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/contact.dart';
import 'chat_screen.dart';
import 'add_contact_screen.dart';
import '../riverpod/providers.dart';

class ContactsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddContactScreen()),
              );
            },
          ),
        ],
      ),
      body: contacts.isEmpty
          ? Center(child: Text('No contacts found'))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(contact: contact),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
