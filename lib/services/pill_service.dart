import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pill_reminder.dart';

class PillService {
  static const String _storageKey = 'pill_reminders';

  Future<void> addPill(PillReminder pill) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedList = prefs.getStringList(_storageKey) ?? [];

    storedList.add(jsonEncode(pill.toJson()));
    await prefs.setStringList(_storageKey, storedList);
  }

  Future<List<PillReminder>> getPills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedList = prefs.getStringList(_storageKey) ?? [];

    return storedList
        .map((item) => PillReminder.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> removePill(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedList = prefs.getStringList(_storageKey) ?? [];

    storedList.removeAt(index);
    await prefs.setStringList(_storageKey, storedList);
  }
  
  // Additional useful methods
  
  Future<void> updatePill(int index, PillReminder updatedPill) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedList = prefs.getStringList(_storageKey) ?? [];
    
    if (index >= 0 && index < storedList.length) {
      storedList[index] = jsonEncode(updatedPill.toJson());
      await prefs.setStringList(_storageKey, storedList);
    }
  }
  
  Future<void> togglePillCompletion(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedList = prefs.getStringList(_storageKey) ?? [];
    
    if (index >= 0 && index < storedList.length) {
      final pill = PillReminder.fromJson(jsonDecode(storedList[index]));
      final updatedPill = pill.copyWith(isCompleted: !pill.isCompleted);
      storedList[index] = jsonEncode(updatedPill.toJson());
      await prefs.setStringList(_storageKey, storedList);
    }
  }
  
  Future<void> clearAllPills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, []);
  }
}
