import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/home/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  final notifController = Get.find<NotificationController>();

  NotificationScreen({super.key});

  String formatTime(DateTime timestamp) {
    return DateFormat('dd MMM yyyy, HH:mm').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        actions: [
          IconButton(
            onPressed: () => notifController.clearNotifications(),
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            tooltip: "Hapus semua",
          ),
        ],
      ),
      body: Obx(() {
        if (notifController.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.notifications_off_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  "Belum ada notifikasi.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: notifController.notifications.length,
          itemBuilder: (context, index) {
            final notif = notifController.notifications[index];
            return Dismissible(
              key: Key(notif.timestamp.toIso8601String()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                notifController.notifications.removeAt(index);
                notifController.saveNotifications();
                Get.snackbar(
                  "Notifikasi dihapus",
                  notif.title,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      IconData(
                        notif.iconCode,
                        fontFamily: notif.iconFontFamily,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    notif.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notif.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatTime(notif.timestamp),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
