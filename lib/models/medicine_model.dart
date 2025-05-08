class Medicines {
  final List<Medicine> medicine;

  Medicines({
    required this.medicine,
  });

  factory Medicines.fromJson(Map<String, dynamic> json) {
    return Medicines(
      medicine: (json['medicine'] as List)
          .map((item) => Medicine.fromJson(item))
          .toList(),
    );
  }
}

class Medicine {
  final int id;
  final String disease;
  final String imageUrl;
  final String name;
  final String description;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;

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
      imageUrl: 'https://b-medix.im-fall.my.id/storage/medicines/${json['image']}',
      name: json['name'],
      description: json['description'],
      price: json['price'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}