import 'package:flutter/material.dart';

import '../../../models/medicine_model.dart';
import 'medicine_cards.dart';

class MedicineGrid extends StatelessWidget {
  final List<Medicine> medicines;
  final bool isLoading;
  
  const MedicineGrid({
    Key? key,
    required this.medicines,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (medicines.isEmpty) {
      return const Center(
        child: Text('No medicines found'),
      );
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return MedicineCard(medicine: medicine);
      },
    );
  }
}