import 'package:flutter/material.dart';

class MedicineReminder {
  final String id;
  final String medicineName;
  final TimeOfDay time;
  final bool isCompleted;
  final String? notes;
  final String frequency;

  MedicineReminder({
    required this.id,
    required this.medicineName,
    required this.time,
    required this.isCompleted,
    this.notes,
    this.frequency = 'Setiap hari',
  });

  MedicineReminder copyWith({
    String? id,
    String? medicineName,
    TimeOfDay? time,
    bool? isCompleted,
    String? notes,
    String? frequency,
  }) {
    return MedicineReminder(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      notes: notes ?? this.notes,
      frequency: frequency ?? this.frequency,
    );
  }
}
