import 'package:flutter/material.dart';
import '../../models/medicine_reminder.dart';
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
  final List<MedicineReminder> _reminders = [];

  void _addReminder(MedicineReminder reminder) {
    setState(() {
      _reminders.add(reminder);
    });
  }

  void _toggleReminderStatus(String id) {
    setState(() {
      final index = _reminders.indexWhere((reminder) => reminder.id == id);
      if (index != -1) {
        _reminders[index] = _reminders[index].copyWith(
          isCompleted: !_reminders[index].isCompleted,
        );
      }
    });
  }

  void _deleteReminder(String id) {
    setState(() {
      _reminders.removeWhere((reminder) => reminder.id == id);
    });
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
        child: SingleChildScrollView(
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
              const SizedBox(height: 16),
              _reminders.isEmpty
                  ? EmptyReminderState(
                      onAddReminder: _showAddReminderSheet,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _reminders.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final reminder = _reminders[index];
                        return ReminderCard(
                          reminder: reminder,
                          onToggle: _toggleReminderStatus,
                          onDelete: _deleteReminder,
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
