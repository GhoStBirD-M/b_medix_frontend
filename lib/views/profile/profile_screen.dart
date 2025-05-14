import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import './prescription_screen.dart';
import './address_screen.dart';
import './payment_method_screen.dart';
import '../../routes/app_pages.dart';
import '../../views/profile/pill_reminder_screen.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/menu_item.dart';
import '../widgets/common/bottom_navigation.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  ProfileScreen({super.key});

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
                    MenuItem(
                      icon: Icons.shopping_bag_outlined,
                      title: "My Orders",
                      iconColor: Colors.black,
                      onTap: () => Get.toNamed(AppPages.ORDERS),
                    ),
                    MenuItem(
                      icon: Icons.receipt_long_outlined,
                      title: "My Prescription",
                      iconColor: Colors.black,
                      onTap: () => Get.to(PrescriptionScreen()),
                    ),
                    MenuItem(
                      icon: Icons.medical_services_outlined,
                      title: "Doctor Consultation",
                      iconColor: Colors.black,
                      onTap: () => Get.toNamed(AppPages.CONSULTATION),
                    ),
                    MenuItem(
                      icon: Icons.credit_card_outlined,
                      title: "Payment Methods",
                      iconColor: Colors.black,
                      onTap: () => Get.to(PaymentMethodInfoScreen()),
                    ),
                    MenuItem(
                      icon: Icons.location_on_outlined,
                      title: "Your Addresses",
                      iconColor: Colors.black,
                      onTap: () => Get.to(AddressScreen()),
                    ),
                    MenuItem(
                      icon: Icons.alarm_outlined,
                      title: "Pill Reminder",
                      iconColor: Colors.black,
                      onTap: () => Get.to(PillReminderScreen()),
                    ),
                    MenuItem(
                      icon: Icons.person_add_outlined,
                      title: "Invites Friends",
                      iconColor: Colors.black,
                      onTap: () {
                        SharePlus.instance.share(
                          ShareParams(
                            text:
                                'Yuk coba aplikasi ini! Unduh di: wa.me/6285785233923',
                            subject: 'Undangan dari Temanmu',
                          ),
                        );
                      },
                    ),
                    MenuItem(
                      icon: Icons.logout_outlined,
                      title: "Log out",
                      iconColor: Colors.red,
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text("Confirm Logout"),
                            backgroundColor: Colors.white,
                            content: const SizedBox(
                              width: 300,
                              child: Text("Are you sure you want to Logout?"),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  Get.back(); // tutup dialog
                                  authController.logout();
                                },
                                child: const Text("Logout",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      },
                    ),
                    MenuItem(
                      icon: Icons.delete_outline,
                      title: "Delete Account",
                      iconColor: Colors.red,
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text("Confirm Deletion"),
                            backgroundColor: Colors.white,
                            content: const SizedBox(
                              width: 300, // atur lebar di sini
                              child: Text(
                                  "Are you sure you want to delete your account?"),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  Get.back(); // tutup dialog
                                  authController.deleteAccount();
                                },
                                child: const Text("Delete",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      },
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
