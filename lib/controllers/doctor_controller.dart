import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/doctor_model.dart';
import '../services/doctor_service.dart';

class DoctorController extends GetxController {
  final DoctorService _apiService = DoctorService();

  final RxBool isLoading = false.obs;
  final RxList<Doctor> allDoctors = <Doctor>[].obs;
  final RxList<Doctor> doctors = <Doctor>[].obs;
  final Rx<Doctor?> selectedDoctor = Rx<Doctor?>(null);

  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();

    debounce(searchQuery, (String query) {
      filterDoctors(query);
    }, time: const Duration(milliseconds: 300));
  }

  Future<void> fetchDoctors() async {
    try {
      isLoading.value = true;
      final result = await _apiService.getDoctors();
      allDoctors.value = result.doctors;
      doctors.value = result.doctors;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void filterDoctors(String query) {
    if (query.isEmpty) {
      doctors.value = allDoctors;
    } else {
      final lower = query.toLowerCase();
      doctors.value = allDoctors.where((doctors) {
        return doctors.name.toLowerCase().contains(lower) ||
            doctors.specialist.toLowerCase().contains(lower);
      }).toList();
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchDoctor(int id) async {
    try {
      isLoading.value = true;
      final result = await _apiService.getDoctor(id);
      selectedDoctor.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
