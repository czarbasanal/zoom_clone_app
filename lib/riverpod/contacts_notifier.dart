import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';
import 'providers.dart';

class ContactsNotifier extends StateNotifier<List<Contact>> {
  final Ref ref;

  ContactsNotifier(this.ref) : super([]);

  Future<void> loadContacts() async {
    final user = ref.read(userProvider);
    if (user != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(user.id)
          .collection('contacts')
          .get();

      final contacts = querySnapshot.docs.map((doc) {
        return Contact.fromMap(doc.id, doc.data());
      }).toList();

      state = contacts;
      // print('Loaded contacts: ${contacts.length}');
    } else {
      print('No user ID found');
    }
  }

  Future<void> addContact(Contact contact) async {
    final user = ref.read(userProvider);
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(user.id)
          .collection('contacts')
          .doc(contact.id)
          .set(contact.toMap());

      state = [...state, contact];
      print('Contact added: ${contact.email}');
    } else {
      print('No user ID found');
    }
  }
}
