class LocalNotification {
  final String title;
  final String message;
  final DateTime timestamp;
  final String iconName;

  LocalNotification({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.iconName,
  });

  factory LocalNotification.fromJson(Map<String, dynamic> json) {
    return LocalNotification(
      title: json['title'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      iconName: json['iconName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
        'iconName': iconName,
      };
}
