import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../views/widgets/prescription/add_prescription_sheet.dart';
import 'package:uuid/uuid.dart';
import '../../models/profile/prescription_model.dart';

class PrescriptionController extends GetxController {
  final storage = GetStorage();
  final prescriptions = <Prescription>[].obs;
  final isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadPrescriptions();
  }

  void loadPrescriptions() {
    isLoading.value = true;
    try {
      final List<dynamic> storedData = storage.read('prescriptions') ?? [];
      prescriptions.value = storedData
          .map((item) => Prescription.fromJson(item))
          .toList();
    } catch (e) {
      debugPrint('Error loading prescriptions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void savePrescriptions() {
    try {
      final List<Map<String, dynamic>> data = 
          prescriptions.map((item) => item.toJson()).toList();
      storage.write('prescriptions', data);
    } catch (e) {
      debugPrint('Error saving prescriptions: $e');
    }
  }

  void addPrescription(Prescription prescription) {
    final newPrescription = prescription.copyWith(
      id: const Uuid().v4(),
    );
    prescriptions.add(newPrescription);
    savePrescriptions();
    Get.back();
    Get.snackbar(
      'Success',
      'Resep berhasil ditambahkan',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void updatePrescription(Prescription prescription) {
    final index = prescriptions.indexWhere((p) => p.id == prescription.id);
    if (index != -1) {
      prescriptions[index] = prescription;
      prescriptions.refresh();
      savePrescriptions();
      Get.back();
      Get.snackbar(
        'Success',
        'Resep berhasil diperbarui',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void deletePrescription(String id) {
    prescriptions.removeWhere((p) => p.id == id);
    savePrescriptions();
    Get.snackbar(
      'Berhasil',
      'Resep berhasil dihapus',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showAddPrescriptionSheet({Prescription? prescription}) {
    Get.bottomSheet(
      AddPrescriptionSheet(prescription: prescription),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}