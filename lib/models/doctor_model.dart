// ignore_for_file: unnecessary_type_check

class Doctors {
  final List<Doctor> doctors;

  Doctors({
    required this.doctors,
  });
  
  factory Doctors.fromJson(List<dynamic> json) {
    // // Handle case where data might be directly in the json or in a 'data' field
    // final List<dynamic> doctorsList;
    
    // if (json['data'] != null) {
    //   // If the API returns { "data": [...] }
    //   doctorsList = json['data'];
    // } else if (json is Map && json.containsKey('doctors')) {
    //   // If the API returns { "doctors": [...] }
    //   doctorsList = json['doctors'];
    // } else {
    //   // If the API returns the list directly at the root level
    //   doctorsList = json.containsKey('data') ? json['data'] : (json is List ? json : []);
    // }
    
    return Doctors(
      doctors: List<Doctor>.from(json.map((x) => Doctor.fromJson(x))),
    );
  }
}

class Doctor {
  final int id;
  final dynamic image;
  final String name;
  final String specialist;
  final DateTime createdAt;
  final DateTime updatedAt;

  Doctor({
    required this.id,
    required this.image,
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