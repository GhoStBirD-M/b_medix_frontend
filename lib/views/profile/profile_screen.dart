import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:tes_main/views/profile/pill_reminder_screen.dart';
import 'package:tes_main/views/profile/prescription_list_screen.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/menu_item.dart';
import '../widgets/common/bottom_navigation.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onTap;
  final AuthController authController = Get.find();

  ProfileScreen({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final user = authController.user.value;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            // Profile Header
            ProfileHeader(
              name: user.name,
              email: user.email,
              registeredDate: user.createdAt,
            ),

            // Menu Items
            Expanded(
              child: Container(
                color: const Color(0xFFF5F5F5),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const MenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: "My Orders",
                      iconColor: Colors.black,
                    ),
                    const MenuItem(
                      icon: Icons.favorite_border,
                      title: "My Wishlist",
                      iconColor: Colors.black,
                    ),
                    MenuItem(
                      icon: Icons.receipt_long_outlined,
                      title: "My Prescription",
                      iconColor: Colors.black,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PrescriptionListScreen()));
                      },
                    ),
                    const MenuItem(
                      icon: Icons.science_outlined,
                      title: "Your Lab Test",
                      iconColor: Colors.black,
                    ),
                    const MenuItem(
                      icon: Icons.medical_services_outlined,
                      title: "Doctor Consultation",
                      iconColor: Colors.black,
                    ),
                    const MenuItem(
                      icon: Icons.credit_card_outlined,
                      title: "Payment Methods",
                      iconColor: Colors.black,
                    ),
                    const MenuItem(
                      icon: Icons.location_on_outlined,
                      title: "Your Addresses",
                      iconColor: Colors.black,
                    ),
                    MenuItem(
                      icon: Icons.alarm_outlined,
                      title: "Pill Reminder",
                      iconColor: Colors.black,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PillReminderScreen()));
                      },
                    ),
                    const MenuItem(
                      icon: Icons.person_add_outlined,
                      title: "Invites Friends",
                      iconColor: Colors.black,
                    ),
                    MenuItem(
                      icon: Icons.logout_outlined,
                      title: "Log out",
                      iconColor: Colors.red,
                      onTap: () => authController.logout(),
                    ),
                    const MenuItem(
                      icon: Icons.delete_outline,
                      title: "Delete Account",
                      iconColor: Colors.red,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
    );
  }
}
