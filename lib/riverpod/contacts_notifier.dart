import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';
import 'providers.dart';

class ContactsNotifier extends StateNotifier<List<Contact>> {
  final Ref ref;

  ContactsNotifier(this.ref) : super([]);

  Stream<void> loadContacts() {
    final user = ref.read(userProvider);
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(user.id)
          .collection('contacts')
          .snapshots()
          .map((snapshot) {
        final contacts = snapshot.docs.map((doc) {
          return Contact.fromMap(doc.id, doc.data());
        }).toList();
        state = contacts;
        print('Loaded contacts: ${contacts.length}');
      });
    } else {
      print('No user ID found');
      return Stream.value(null);
    }
  }

  Future<void> addContact(String email) async {
    final user = ref.read(userProvider);
    if (user != null) {
      // Find the contact's document by email
      final contactQuerySnapshot = await FirebaseFirestore.instance
          .collection('UserCollection')
          .where('email', isEqualTo: email)
          .get();

      if (contactQuerySnapshot.docs.isNotEmpty) {
        final contactDoc = contactQuerySnapshot.docs.first;
        final contactData = contactDoc.data();
        final contact = Contact.fromMap(contactDoc.id, contactData);

        // Add the contact to the current user's contacts subcollection
        await FirebaseFirestore.instance
            .collection('UserCollection')
            .doc(user.id)
            .collection('contacts')
            .doc(contact.id)
            .set(contact.toMap());

        // Add the current user to the contact's contacts subcollection
        await FirebaseFirestore.instance
            .collection('UserCollection')
            .doc(contact.id)
            .collection('contacts')
            .doc(user.id)
            .set({
          'email': user.email,
          'name': user.name,
          'photoURL': user.photoURL,
        });

        state = [...state, contact];
        print('Contact added: ${contact.email}');
      } else {
        print('Contact not found: $email');
      }
    } else {
      print('No user ID found');
    }
  }
}
