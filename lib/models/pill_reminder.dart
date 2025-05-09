import 'package:flutter/material.dart';

class PillReminder {
  final String id;
  final String medicineName;
  final String time; // Stored as HH:mm format
  final bool isCompleted;
  final String? notes;
  final String frequency;

  PillReminder({
    required this.id,
    required this.medicineName,
    required this.time,
    required this.isCompleted,
    this.notes,
    this.frequency = 'Setiap hari',
  });

  // Convert TimeOfDay to string for storage
  static String timeOfDayToString(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }

  // Convert string to TimeOfDay for display
  static TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  // Create a copy of this PillReminder with modified fields
  PillReminder copyWith({
    String? id,
    String? medicineName,
    String? time,
    bool? isCompleted,
    String? notes,
    String? frequency,
  }) {
    return PillReminder(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      notes: notes ?? this.notes,
      frequency: frequency ?? this.frequency,
    );
  }

  // Convert PillReminder to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineName': medicineName,
      'time': time,
      'isCompleted': isCompleted,
      'notes': notes,
      'frequency': frequency,
    };
  }

  // Create PillReminder from JSON data
  factory PillReminder.fromJson(Map<String, dynamic> json) {
    return PillReminder(
      id: json['id'],
      medicineName: json['medicineName'],
      time: json['time'],
      isCompleted: json['isCompleted'],
      notes: json['notes'] ?? '',
      frequency: json['frequency'] ?? 'Setiap hari',
    );
  }

  // Create a new PillReminder with a unique ID
  factory PillReminder.create({
    required String medicineName,
    required TimeOfDay time,
    String? notes,
    String frequency = 'Setiap hari',
  }) {
    return PillReminder(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      medicineName: medicineName,
      time: timeOfDayToString(time),
      isCompleted: false,
      notes: notes,
      frequency: frequency,
    );
  }
}
