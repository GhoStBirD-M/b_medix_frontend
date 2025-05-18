import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import '../models/profile/pill_reminder_model.dart';

class PillService {
  static const String _storageKey = 'pill_reminders';
  final GetStorage _box = GetStorage();

  Future<void> addPill(PillReminder pill) async {
    List<String> storedList = _box.read<List<dynamic>>(_storageKey)?.cast<String>() ?? [];
    storedList.add(jsonEncode(pill.toJson()));
    await _box.write(_storageKey, storedList);
  }

  Future<List<PillReminder>> getPills() async {
    List<String> storedList = _box.read<List<dynamic>>(_storageKey)?.cast<String>() ?? [];
    return storedList
        .map((item) => PillReminder.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> removePill(int index) async {
    List<String> storedList = _box.read<List<dynamic>>(_storageKey)?.cast<String>() ?? [];
    if (index >= 0 && index < storedList.length) {
      storedList.removeAt(index);
      await _box.write(_storageKey, storedList);
    }
  }

  Future<void> updatePill(int index, PillReminder updatedPill) async {
    List<String> storedList = _box.read<List<dynamic>>(_storageKey)?.cast<String>() ?? [];
    if (index >= 0 && index < storedList.length) {
      storedList[index] = jsonEncode(updatedPill.toJson());
      await _box.write(_storageKey, storedList);
    }
  }

  Future<void> togglePillCompletion(int index) async {
    List<String> storedList = _box.read<List<dynamic>>(_storageKey)?.cast<String>() ?? [];
    if (index >= 0 && index < storedList.length) {
      final pill = PillReminder.fromJson(jsonDecode(storedList[index]));
      final updatedPill = pill.copyWith(isCompleted: !pill.isCompleted);
      storedList[index] = jsonEncode(updatedPill.toJson());
      await _box.write(_storageKey, storedList);
    }
  }

  Future<void> clearAllPills() async {
    await _box.write(_storageKey, []);
  }
}
