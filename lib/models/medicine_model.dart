import '../utils/constants.dart';

class Medicine {
  final int id;
  final String disease;
  final String imageUrl;
  final String name;
  final String description;
  final String price;
  final String createdAt;
  final String updatedAt;

  Medicine({
    required this.id,
    required this.disease,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      disease: json['disease'],
      imageUrl: 'https://b-medix.im-fall.my.id/storage/${json['image']}',
      name: json['name'],
      description: json['description'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}