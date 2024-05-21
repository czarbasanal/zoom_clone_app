class User {
  final String id;
  final String email;
  final String name;
  final String photoURL;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.photoURL});

  factory User.fromMap(String id, Map<String, dynamic> data) {
    return User(
      id: id,
      email: data['email'],
      name: data['name'],
      photoURL: data['photoURL'],
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
