import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';
import 'providers.dart';

class ContactsNotifier extends StateNotifier<List<Contact>> {
  final Ref ref;

  ContactsNotifier(this.ref) : super([]) {
    loadContacts();
  }

  Future<void> loadContacts() async {
    final userId = ref.read(userProvider)?.id;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(userId)
          .collection('contacts')
          .get();
      state = snapshot.docs
          .map((doc) => Contact.fromMap(doc.id, doc.data()))
          .toList();
      print('Loaded contacts: ${state.length}');
    } else {
      print('No user ID found');
    }
  }

  Future<void> addContact(Contact contact) async {
    final userId = ref.read(userProvider)?.id;
    if (userId != null) {
      final docRef = FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(userId)
          .collection('contacts')
          .doc(contact.id);
      await docRef.set(contact.toMap());
      state = [...state, contact];
      print('Contact added: ${contact.email}');
    }
  }

  void reset() {
    state = [];
  }
}
