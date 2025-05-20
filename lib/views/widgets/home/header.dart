import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_main/views/home/notif_screen.dart';
import '../../../routes/app_pages.dart';

class Header extends StatelessWidget {
  final String greeting;
  final String name;
  final String profilePic;
  final GlobalKey? notificationKey; // Add key for notification icon
  final GlobalKey? cartKey; // Add key for cart icon

  const Header({
    super.key,
    required this.greeting,
    required this.name,
    required this.profilePic,
    this.notificationKey,
    this.cartKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(profilePic),
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 12),
          
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
          
          IconButton(
            key: notificationKey, // Assign key to notification icon
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.black,
            onPressed: () => Get.to(NotificationScreen()),
          ),
          
          IconButton(
            key: cartKey, // Assign key to cart icon
            icon: const Icon(Icons.shopping_cart_outlined),
            color: Colors.black,
            onPressed: () {
              Get.toNamed(AppPages.CART);
            },
          ),
        ],
      ),
    );
  }
}