import 'package:b_medix_frontend/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class Header extends StatelessWidget {
  final String greeting;
  final String name;
  final String avatarUrl;
  final AuthController authController = Get.find();

  Header({
    super.key,
    required this.greeting,
    required this.name,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(avatarUrl),
            backgroundColor: Colors.grey[300],
            child:
                avatarUrl == '/placeholder.svg'
                    ? const Icon(Icons.person, size: 30, color: Colors.grey)
                    : null,
          ),
          const SizedBox(width: 12),

          // Greeting and name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Notification icon
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.black,
            onPressed: () {},
          ),

          // Cart icon
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.red,
            onPressed: () => authController.logout(),
          ),
        ],
      ),
    );
  }
}
