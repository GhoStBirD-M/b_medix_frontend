import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_main/routes/app_pages.dart';
import 'package:tes_main/views/consultation/medicine_details.dart';
import '../../controllers/medicine_controller.dart';
import '../../views/widgets/medicine/medicine_cards.dart';

class MedicineTab extends StatelessWidget {
  MedicineTab({Key? key}) : super(key: key);

  final MedicineController medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Medicine',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),

        Expanded(
          child: Obx(() {
            if (medicineController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: medicineController.medicines.length,
              itemBuilder: (context, index) {
                final medicine = medicineController.medicines[index];
                return GestureDetector(
                    onTap: () {
                      medicineController.fetchMedicineDetails(medicine.id);
                      Get.toNamed(AppPages.MEDICINE_DETAILS, arguments: medicine.id);
                    }, 
                    child: MedicineCard(medicine: medicine));
              },
            );
          }),
        ),
      ],
    );
  }
}
