import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/profile/local_notification.dart';

class NotificationController extends GetxController {
  final box = GetStorage();
  final RxList<LocalNotification> notifications = <LocalNotification>[].obs;

  final String storageKey = 'local_notifications';

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    final raw = box.read<List>(storageKey);
    if (raw != null) {
      notifications.value = raw.map((e) {
        final map = Map<String, dynamic>.from(e);
        // Jika data lama belum punya iconCode/iconFontFamily, kasih default
        if (!map.containsKey('iconCode')) {
          map['iconCode'] = 0xe7f4; // kode default Icons.notifications_outlined
          map['iconFontFamily'] = 'MaterialIcons';
        }
        return LocalNotification.fromJson(map);
      }).toList();
    }
  }

  void addNotification(String title, String message, IconData icon) {
    final newNotif = LocalNotification(
      title: title,
      message: message,
      timestamp: DateTime.now(),
      iconCode: icon.codePoint,
      iconFontFamily: icon.fontFamily ?? 'MaterialIcons',
    );

    notifications.add(newNotif);
    saveNotifications();
  }

  void clearNotifications() {
    notifications.clear();
    saveNotifications();
  }

  void saveNotifications() {
    final data = notifications.map((e) => e.toJson()).toList();
    box.write(storageKey, data);
  }
}
