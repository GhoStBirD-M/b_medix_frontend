class User {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;
  // final String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    // this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
      // token: json['token'],
    );
  }
}
