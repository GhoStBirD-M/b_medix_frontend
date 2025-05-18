class Address {
  final String id;
  final String label;
  final String recipient;
  final String phoneNumber;
  final String fullAddress;
  final String city;
  final String postalCode;
  final bool isDefault;

  Address({
    required this.id,
    required this.label,
    required this.recipient,
    required this.phoneNumber,
    required this.fullAddress,
    required this.city,
    required this.postalCode,
    this.isDefault = false,
  });

  Address copyWith({
    String? id,
    String? label,
    String? recipient,
    String? phoneNumber,
    String? fullAddress,
    String? city,
    String? postalCode,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      label: label ?? this.label,
      recipient: recipient ?? this.recipient,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullAddress: fullAddress ?? this.fullAddress,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'recipient': recipient,
      'phoneNumber': phoneNumber,
      'fullAddress': fullAddress,
      'city': city,
      'postalCode': postalCode,
      'isDefault': isDefault,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      label: json['label'],
      recipient: json['recipient'],
      phoneNumber: json['phoneNumber'],
      fullAddress: json['fullAddress'],
      city: json['city'],
      postalCode: json['postalCode'],
      isDefault: json['isDefault'] ?? false,
    );
  }
}