import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/medicine_controller.dart';
import '../../views/widgets/medicine/medicine_search_bar.dart';
import '../../views/widgets/medicine/medicine_grid.dart';
import '../../views/widgets/medicine/loading_indicator.dart';
import '../../views/widgets/medicine/empty_medicine_state.dart';

class MedicineTab extends StatelessWidget {
  MedicineTab({Key? key}) : super(key: key);

  final MedicineController medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar Component
        MedicineSearchBar(
          onChanged: (query) {
            // Implement search functionality if needed
            // medicineController.updateSearchQuery(query);
          },
        ),
        
        // Medicine Grid with Loading and Empty States
        Expanded(
          child: Obx(() {
            if (medicineController.isLoading.value) {
              return const LoadingIndicator();
            }
            
            if (medicineController.medicines.isEmpty) {
              return EmptyMedicineState(
                onRefresh: () => medicineController.fetchMedicines(),
              );
            }
            
            return MedicineGrid(
              medicines: medicineController.medicines,
              // onMedicineTap: (medicine) {
                // Navigate to medicine details
                // Get.toNamed('/medicine-details', arguments: medicine);
              // },
              // onAddToCart: (medicine) {
                // Add to cart functionality
                // medicineController.addToCart(medicine);
                // Get.snackbar(
                  // 'Added to Cart',
                  // '${medicine.name} added to your cart',
                  // snackPosition: SnackPosition.BOTTOM,
                // );
              // },
            );
          }),
        ),
      ],
    );
  }
}