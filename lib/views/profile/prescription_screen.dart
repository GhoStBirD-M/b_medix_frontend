import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile/prescription_controller.dart';
import '../widgets/prescription/empty_state_widget.dart';
import '../widgets/prescription/prescription_item_widget.dart';


class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrescriptionController());
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Prescription',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.prescriptions.isEmpty) {
          return const EmptyStateWidget();
        }
        
        return ListView.builder(
          padding: const EdgeInsets.only(top: 16, bottom: 80),
          itemCount: controller.prescriptions.length,
          itemBuilder: (context, index) {
            final prescription = controller.prescriptions[index];
            return PrescriptionItemWidget(prescription: prescription);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.showAddPrescriptionSheet(),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}