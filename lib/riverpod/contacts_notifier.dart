import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom/riverpod/providers.dart';
import '../models/contact.dart';

class ContactsNotifier extends StateNotifier<List<Contact>> {
  final Ref ref;
  StreamSubscription<List<Contact>>? _streamSubscription;

  ContactsNotifier(this.ref) : super([]) {
    _initializeContactsStream();
  }

  void _initializeContactsStream() {
    final user = ref.read(userProvider);
    if (user == null) {
      print('No user ID found');
      return;
    }

    _streamSubscription = FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(user.id)
        .collection('contacts')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Contact.fromMap(doc.id, doc.data()))
            .toList())
        .listen((contacts) {
      state = contacts;
      print('Loaded contacts: ${contacts.length}');
    }, onError: (error) {
      print('Error loading contacts: $error');
    });
  }

  Future<void> addContact(String email) async {
    final user = ref.read(userProvider);
    if (user == null) {
      print('No user ID found');
      return;
    }

    final contactQuerySnapshot = await FirebaseFirestore.instance
        .collection('UserCollection')
        .where('email', isEqualTo: email)
        .get();

    if (contactQuerySnapshot.docs.isNotEmpty) {
      final contactDoc = contactQuerySnapshot.docs.first;
      final contactData = contactDoc.data();
      final contact = Contact.fromMap(contactDoc.id, contactData);

      final conversationId = _createConversationId(user.id, contact.id);

      final batch = FirebaseFirestore.instance.batch();

      final currentUserContactRef = FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(user.id)
          .collection('contacts')
          .doc(contact.id);
      batch.set(currentUserContactRef, contact.toMap());

      final currentUserConversationRef = FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(user.id)
          .collection('conversations')
          .doc(conversationId);
      batch.set(currentUserConversationRef, {'contactId': contact.id});

      final contactUserRef = FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(contact.id)
          .collection('contacts')
          .doc(user.id);
      batch.set(contactUserRef, {
        'email': user.email,
        'name': user.name,
        'photoURL': user.photoURL,
      });

      final contactConversationRef = FirebaseFirestore.instance
          .collection('UserCollection')
          .doc(contact.id)
          .collection('conversations')
          .doc(conversationId);
      batch.set(contactConversationRef, {'contactId': user.id});

      await batch.commit();
      print('Contact added: ${contact.email}');
    } else {
      print('Contact not found: $email');
    }
  }

  String _createConversationId(String userId1, String userId2) {
    return userId1.compareTo(userId2) < 0
        ? '$userId1-$userId2'
        : '$userId2-$userId1';
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void reset() {
    state = [];
  }
}
