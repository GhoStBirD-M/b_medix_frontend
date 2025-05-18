class Prescription {
  final String id;
  final String doctorName;
  final String patientName;
  final String diagnosis;
  final String medications;
  final String date;
  final String notes;

  Prescription({
    required this.id,
    required this.doctorName,
    required this.patientName,
    required this.diagnosis,
    required this.medications,
    required this.date,
    this.notes = '',
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'],
      doctorName: json['doctorName'],
      patientName: json['patientName'],
      diagnosis: json['diagnosis'],
      medications: json['medications'],
      date: json['date'],
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorName': doctorName,
      'patientName': patientName,
      'diagnosis': diagnosis,
      'medications': medications,
      'date': date,
      'notes': notes,
    };
  }

  Prescription copyWith({
    String? id,
    String? doctorName,
    String? patientName,
    String? diagnosis,
    String? medications,
    String? date,
    String? notes,
  }) {
    return Prescription(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      patientName: patientName ?? this.patientName,
      diagnosis: diagnosis ?? this.diagnosis,
      medications: medications ?? this.medications,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }
}