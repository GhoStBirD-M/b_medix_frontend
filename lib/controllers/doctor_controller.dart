import 'package:get/get.dart';
import '../models/doctor_model.dart';
import '../services/doctor_service.dart';

class DoctorController extends GetxController {
  final DoctorService _apiService = DoctorService();

  final RxBool isLoading = false.obs;
  final RxList<Doctor> doctors = <Doctor>[].obs;
  final Rx<Doctor?> selectedDoctor = Rx<Doctor?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      isLoading.value = true;
      final result = await _apiService.getDoctors();
      doctors.value = result.doctors;
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDoctor(int id) async {
    try {
      isLoading.value = true;
      final result = await _apiService.getDoctor(id);
      selectedDoctor.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
