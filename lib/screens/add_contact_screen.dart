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
                  final user = ref.read(userProvider);
                  if (user != null) {
                    final contact = Contact(
                      id: email,
                      email: email,
                      name:
                          'User Name', // You can fetch and set the actual name from Firestore if needed
                      photoURL: '',
                    );
                    await ref
                        .read(contactsProvider.notifier)
                        .addContact(contact);
                    Navigator.pop(context);
                  } else {
                    print('No user logged in');
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
