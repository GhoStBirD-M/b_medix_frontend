import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/pill_reminder_controller.dart';
import '../widgets/pill/reminder_card.dart';
import '../widgets/pill/empty_reminder_state.dart';
import '../widgets/pill/add_reminder_sheet.dart';

class PillReminderScreen extends StatelessWidget {
  final PillReminderController controller = Get.put(PillReminderController());

  PillReminderScreen({super.key});

  void _showAddReminderSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddReminderSheet(
        onAddReminder: (reminder) => controller.addReminder(reminder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pill Reminder',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                controller.reminders.isEmpty
                    ? EmptyReminderState(
                        onAddReminder: () => _showAddReminderSheet(context),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.reminders.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final reminder = controller.reminders[index];
                          return ReminderCard(
                            reminder: reminder,
                            onToggle: () =>
                                controller.toggleReminderStatus(index),
                            onDelete: () => controller.deleteReminder(index),
                          );
                        },
                      ),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddReminderSheet(context),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
