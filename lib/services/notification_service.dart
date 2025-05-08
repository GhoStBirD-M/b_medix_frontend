import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/medicine_reminder.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> scheduleNotification(MedicineReminder reminder) async {
    final now = DateTime.now();
    final scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      reminder.time.hour,
      reminder.time.minute,
    );
    
    // If the time is in the past, schedule for tomorrow
    final notificationTime = scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(reminder.id),
      'Waktunya minum obat',
      'Jangan lupa minum ${reminder.medicineName}',
      tz.TZDateTime.from(notificationTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'medication_channel',
          'Medication Reminders',
          channelDescription: 'Notifications for medication reminders',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFF1A9F8F),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(String id) async {
    await flutterLocalNotificationsPlugin.cancel(int.parse(id));
  }
}
