import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/medicine/medicine_model.dart';
import '../../services/medicine_service.dart';

class MedicineController extends GetxController {
  final MedicineService _apiService = MedicineService();

  // Observable variables
  final RxList<Medicine> allMedicines = <Medicine>[].obs;
  final RxList<Medicine> topMedicines = <Medicine>[].obs;
  final RxList<Medicine> medicines = <Medicine>[].obs;
  final Rx<Medicine?> selectedMedicine = Rx<Medicine?>(null);
  final RxBool isLoading = false.obs;

  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();

    debounce(searchQuery, (String query) {
      filterMedicines(query);
    }, time: const Duration(milliseconds: 300));
  }

  Future<void> fetchMedicines() async {
    try {
      isLoading.value = true;
      final List<Medicine> result = await _apiService.getMedicines();
      allMedicines.value = result;
      medicines.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load medicines: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterMedicines(String query) {
    if (query.isEmpty) {
      medicines.value = allMedicines;
    } else {
      medicines.value = allMedicines
          .where((medicine) =>
              medicine.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchMedicineDetails(int id) async {
    try {
      isLoading.value = true;
      final result = await _apiService.getMedicineDetails(id);
      selectedMedicine.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load medicine details: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTopMedicines() async {
    try {
      final result = await _apiService.getMedicines();
      topMedicines.value = result.take(3).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load top medicines: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
