class Conversation {
  final String id;
  final List<String> participants;

  Conversation({required this.id, required this.participants});

  factory Conversation.fromMap(String id, Map<String, dynamic> data) {
    return Conversation(
      id: id,
      participants: List<String>.from(data['participants']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
    };
  }
}
