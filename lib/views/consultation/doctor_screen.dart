import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../controllers/doctor_controller.dart';
// import '../../routes/app_pages.dart';
import '../../views/widgets/common/consult_tab_bar.dart';
import '../../views/widgets/common/search_bar.dart';
import '../../views/consultation/medicine_tabs.dart';
import '../widgets/common/bottom_navigation.dart';
import '../widgets/doctor/doctor_card.dart';
// import './doctor_chat_screen.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with SingleTickerProviderStateMixin {
  final DoctorController controller = Get.put(DoctorController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Consultation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => Get.offAllNamed(AppPages.CART), icon: const Icon(Icons.shopping_cart_outlined)),
                const SizedBox(width: 16),
              ],
            ),
          ),

          // Tab Bar
          ConsultationTabBar(tabController: _tabController),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: [
                    // Search Bar
                    CustomSearchBar(hintText: 'Search for doctors'),
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          itemCount: controller.doctors.length,
                          itemBuilder: (context, index) {
                            final doctor = controller.doctors[index];
                            return DoctorCard(
                              imageUrl: 'assets/images/doc_icon.png',
                              name: doctor.name,
                              specialist: doctor.specialist,
                              openTime: "08:00",
                              closeTime: "17:00",
                              onPressed: () =>
                                  Get.toNamed('/chat/${doctor.id}'),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
                MedicineTab(),
              ],
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigation(currentIndex: 1),
    );
  }
}
