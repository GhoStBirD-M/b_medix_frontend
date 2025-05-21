import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../home/notification_controller.dart';
import '../../main.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../models/profile/pill_reminder_model.dart';
import '../../services/pill_reminder_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PillReminderController extends GetxController {
  final PillService _pillService = PillService();
  final notifController = Get.find<NotificationController>();

  var reminders = <PillReminder>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadReminders();
  }

  Future<void> loadReminders() async {
    isLoading.value = true;
    try {
      final result = await _pillService.getPills();
      reminders.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat pengingat: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addReminder(PillReminder reminder) async {
    try {
      await _pillService.addPill(reminder);
      final notifId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      await scheduleNotification(
        id: notifId,
        title: 'Saatnya minum obat!',
        body: reminder.medicineName,
        scheduledTime: reminder.scheduledDateTime(),
      );
      await loadReminders();
      Get.snackbar('Success', 'Pengingat berhasil ditambahkan',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
      notifController.addNotification(
        'Pengingat',
        'Pengingat minum obat berhasil ditambahkan',
        'notifications_active_outlined',
      );
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambahkan pengingat: $e');
    }
  }

  Future<void> toggleReminderStatus(int index) async {
    try {
      await _pillService.togglePillCompletion(index);
      await loadReminders();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui status: $e');
    }
  }

  Future<void> deleteReminder(int index) async {
    try {
      await _pillService.removePill(index);
      await loadReminders();
      Get.snackbar('Success', 'Pengingat berhasil dihapus',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus pengingat: $e');
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'pill_channel_id',
      'Pill Reminders',
      channelDescription: 'Notifikasi pengingat minum obat',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // untuk daily reminder
    );
  }
}
