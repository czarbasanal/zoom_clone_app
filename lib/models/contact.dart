class Contact {
  final String id;
  final String email;
  final String name;
  final String photoURL;

  Contact({
    required this.id,
    required this.email,
    required this.name,
    required this.photoURL,
  });

  factory Contact.fromMap(String id, Map<String, dynamic> data) {
    return Contact(
      id: id,
      email: data['email'] ?? 'You',
      name: data['name'] ?? 'Just You',
      photoURL: data['photoURL'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'photoURL': photoURL,
    };
  }
}
