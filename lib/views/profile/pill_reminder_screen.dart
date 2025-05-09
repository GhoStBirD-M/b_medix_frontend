import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tes_main/services/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../models/pill_reminder.dart';
import '../../services/pill_service.dart';
import '../widgets/pill/reminder_card.dart';
import '../widgets/pill/empty_reminder_state.dart';
import '../widgets/pill/add_reminder_sheet.dart';
import '../../theme/app_theme.dart';

class PillReminderScreen extends StatefulWidget {
  const PillReminderScreen({Key? key}) : super(key: key);

  @override
  State<PillReminderScreen> createState() => _PillReminderScreenState();
}

class _PillReminderScreenState extends State<PillReminderScreen> {
  final PillService _pillService = PillService();
  List<PillReminder> _reminders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pills = await _pillService.getPills();
      setState(() {
        _reminders = pills;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading reminders: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addReminder(PillReminder reminder) async {
    try {
      await _pillService.addPill(reminder);
      await _loadReminders();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding reminder: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _toggleReminderStatus(int index) async {
    try {
      await _pillService.togglePillCompletion(index);
      await _loadReminders();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating reminder: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteReminder(int index) async {
    try {
      await _pillService.removePill(index);
      await _loadReminders();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting reminder: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAddReminderSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddReminderSheet(
        onAddReminder: _addReminder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pill Reminder',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Daftar Pengingat',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await NotificationService()
                              .flutterLocalNotificationsPlugin
                              .zonedSchedule(
                                999,
                                'Test Notification',
                                'Ini adalah notifikasi percobaan',
                                tz.TZDateTime.now(tz.local)
                                    .add(Duration(seconds: 5)),
                                const NotificationDetails(
                                  android: AndroidNotificationDetails(
                                    'test_channel',
                                    'Test Notifications',
                                    channelDescription:
                                        'Channel tes notifikasi',
                                    importance: Importance.high,
                                    priority: Priority.high,
                                  ),
                                  iOS: DarwinNotificationDetails(),
                                ),
                                androidScheduleMode:
                                    AndroidScheduleMode.exactAllowWhileIdle,
                                uiLocalNotificationDateInterpretation:
                                    UILocalNotificationDateInterpretation
                                        .absoluteTime,
                              );
                        },
                        child: Text('Tes Notifikasi')),
                    const SizedBox(height: 16),
                    _reminders.isEmpty
                        ? EmptyReminderState(
                            onAddReminder: _showAddReminderSheet,
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _reminders.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final reminder = _reminders[index];
                              return ReminderCard(
                                reminder: reminder,
                                onToggle: () => _toggleReminderStatus(index),
                                onDelete: () => _deleteReminder(index),
                              );
                            },
                          ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderSheet,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
