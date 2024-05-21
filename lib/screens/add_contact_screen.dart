import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/contact.dart';
import '../riverpod/providers.dart';

class AddContactScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text;
                if (email.isNotEmpty) {
                  // Here you might want to fetch user details from Firestore
                  // using the email and create a new Contact
                  // This is just a placeholder
                  final contact = Contact(
                      id: email, email: email, name: 'User Name', photoURL: '');
                  print('Adding contact: $contact');
                  try {
                    await ref
                        .read(contactsProvider.notifier)
                        .addContact(contact);
                    print('Contact added successfully');
                    Navigator.pop(context);
                  } catch (e) {
                    print('Error adding contact: $e');
                  }
                }
              },
              child: Text('Add Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
