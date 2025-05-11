import 'package:hive/hive.dart';

part 'prescription.g.dart';

@HiveType(typeId: 0)
class Prescription extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  DateTime date;

  Prescription({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });
}
