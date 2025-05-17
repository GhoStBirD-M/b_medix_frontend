import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class Header extends StatelessWidget {
  final String greeting;
  final String name;
  final String profilePic;

  const Header({
    super.key,
    required this.greeting,
    required this.name,
    required this.profilePic,
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
            child: profilePic == '/placeholder.svg'
                ? const Icon(Icons.person, size: 30, color: Colors.grey)
                : null,
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
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.black,
            onPressed: () {},
          ),
          
          IconButton(
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
