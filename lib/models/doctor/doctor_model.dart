// ignore_for_file: unnecessary_type_check

class Doctors {
  final List<Doctor> doctors;

  Doctors({
    required this.doctors,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) {
    return Doctors(
      doctors: List<Doctor>.from(
        (json['doctors'] as List).map((x) => Doctor.fromJson(x)),
      ),
    );
  }
}

class Doctor {
  final int id;
  final String? image;
  final String name;
  final String specialist;
  final DateTime createdAt;
  final DateTime updatedAt;

  Doctor({
    required this.id,
    this.image,
    required this.name,
    required this.specialist,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      image: json['image'] ?? '',
      name: json['name'],
      specialist: json['specialist'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
