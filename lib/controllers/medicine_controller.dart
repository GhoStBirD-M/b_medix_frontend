import 'package:get/get.dart';
import 'package:tes_main/services/medicine_service.dart';
import '../models/medicine_model.dart';

class MedicineController extends GetxController {
  final MedicineService _apiService = MedicineService();

  final RxList<Medicine> medicines = <Medicine>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchMedicines();
    super.onInit();
  }

  void fetchMedicines() async {
    try {
      isLoading(true);
      final result = await _apiService.getMedicine();
      medicines.value = result;
    } catch (e) {
      print('Error fetching medicines: $e');
    } finally {
      isLoading(false);
    }
  }
}
