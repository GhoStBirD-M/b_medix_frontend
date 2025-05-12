import 'package:flutter/material.dart';
import '../../../models/pill_reminder_model.dart';

class ReminderCard extends StatelessWidget {
  final PillReminder reminder;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final timeOfDay = PillReminder.stringToTimeOfDay(reminder.time);
    
    return Dismissible(
      key: Key(reminder.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        onDelete();
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: reminder.isCompleted
                      ? Colors.green.withOpacity(0.1)
                      : Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  reminder.isCompleted ? Icons.check_circle : Icons.medication_outlined,
                  color: reminder.isCompleted ? Colors.green : Colors.teal,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.medicineName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: reminder.isCompleted ? TextDecoration.lineThrough : null,
                        color: reminder.isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          timeOfDay.format(context),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '•',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          reminder.frequency,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    if (reminder.notes != null && reminder.notes!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          reminder.notes!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Checkbox(
                value: reminder.isCompleted,
                onChanged: (value) {
                  onToggle();
                },
                activeColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
