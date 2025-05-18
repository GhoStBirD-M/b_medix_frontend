class Chat {
  final int userId;
  final int doctorId;
  final String message;
  final String sender;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Chat({
    required this.userId,
    required this.doctorId,
    required this.message,
    required this.sender,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      userId: json['user_id'] ?? 0,
      doctorId: json['doctor_id'] ?? 0,
      message: json['message'] ?? '',
      sender: json['sender'] ?? 'user',
      updatedAt: json['updated_at'] != null 
        ? DateTime.parse(json['updated_at']) 
        : DateTime.now(),
      createdAt: json['created_at'] != null 
        ? DateTime.parse(json['created_at']) 
        : DateTime.now(),
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }
}
