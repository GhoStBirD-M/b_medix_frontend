import 'package:flutter/material.dart';
// import 'package:b_medix/theme/app_theme.dart';

class EmptyReminderState extends StatelessWidget {
  final VoidCallback onAddReminder;

  const EmptyReminderState({
    Key? key,
    required this.onAddReminder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada pengingat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan pengingat obat untuk memulai',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: onAddReminder,
            icon: const Icon(Icons.add),
            label: const Text('Tambah Pengingat'),
          ),
        ],
      ),
    );
  }
}
