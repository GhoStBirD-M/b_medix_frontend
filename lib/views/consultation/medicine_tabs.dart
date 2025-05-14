import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/medicine/medicine_cards_shimmer.dart';
import '../../routes/app_pages.dart';
import '../../views/widgets/common/search_bar.dart';
import '../../controllers/medicine_controller.dart';
import '../../views/widgets/medicine/medicine_cards.dart';

class MedicineTab extends StatelessWidget {
  MedicineTab({super.key});

  final MedicineController medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          hintText: 'Search Medicine',
          onChanged: medicineController.setSearchQuery,
        ),
        Expanded(
          child: Obx(() {
            if (medicineController.isLoading.value) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 3,
                itemBuilder: (context, index) => const MedicineCardShimmer(),
              );
            } else if (medicineController.medicines.isEmpty) {
              return const Center(child: Text('No medicines found'));
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
                      Get.toNamed(AppPages.MEDICINE_DETAILS,
                          arguments: medicine.id);
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
