import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../widgets/home/search_bar.dart';
import '../widgets/medicine/medicine_widgets.dart';
import '../../controllers/medicine/medicine_controller.dart';

class MedicineTab extends StatelessWidget {
  MedicineTab({super.key});

  final MedicineController controller = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          hintText: 'Search Medicine',
          onChanged: controller.setSearchQuery,
        ),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
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
            } else if (controller.medicines.isEmpty) {
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
              itemCount: controller.medicines.length,
              itemBuilder: (context, index) {
                final medicine = controller.medicines[index];
                return GestureDetector(
                    onTap: () {
                      controller.fetchMedicineDetails(medicine.id);
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
