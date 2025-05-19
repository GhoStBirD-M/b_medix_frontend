import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Icons.home,
                label: 'Home',
                isSelected: currentIndex == 0,
                index: 0,
              ),
              _buildNavItem(
                context,
                icon: Icons.medical_services,
                label: 'Consultation',
                isSelected: currentIndex == 1,
                index: 1,
              ),
              _buildNavItem(
                context,
                icon: Icons.article,
                label: 'Article',
                isSelected: currentIndex == 2,
                index: 2,
              ),
              _buildNavItem(
                context,
                icon: Icons.account_circle,
                label: 'Profile',
                isSelected: currentIndex == 3,
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              Get.offAllNamed(AppPages.HOME);
              break;
            case 1:
              Get.offAllNamed(AppPages.CONSULTATION);
              break;
            case 2:
              Get.offAllNamed(AppPages.ARTICLE);
              break;
            case 3:
              Get.offAllNamed(AppPages.PROFILE);
              break;
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Theme.of(context).primaryColor : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
