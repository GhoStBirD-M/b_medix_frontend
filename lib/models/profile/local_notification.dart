class LocalNotification {
  final String title;
  final String message;
  final DateTime timestamp;
  final int iconCode;
  final String iconFontFamily;

  LocalNotification({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.iconCode,
    required this.iconFontFamily,
  });

  factory LocalNotification.fromJson(Map<String, dynamic> json) {
    return LocalNotification(
      title: json['title'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      iconCode: json['iconCode'],
      iconFontFamily: json['iconFontFamily'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
        'iconCode': iconCode,
        'iconFontFamily': iconFontFamily,
      };
}
