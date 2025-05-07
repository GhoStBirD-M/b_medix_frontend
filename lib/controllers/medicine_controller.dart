import 'package:get/get.dart';
import '../models/medicine_model.dart';
import '../services/medicine_service.dart';

class MedicineController extends GetxController {
  final MedicineService _apiService = MedicineService();
  
  // Observable variables
  final RxList<Medicine> medicines = <Medicine>[].obs;
  final Rx<Medicine?> selectedMedicine = Rx<Medicine?>(null);
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    try {
      isLoading.value = true;
      final List<Medicine> result = await _apiService.getMedicines();
      medicines.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load medicines: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
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
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}