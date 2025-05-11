import 'package:flutter/material.dart';
import '../../../models/prescription.dart';
import 'package:intl/intl.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionCard({required this.prescription, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(prescription.title),
        subtitle: Text(DateFormat.yMMMd().format(prescription.date)),
        onTap: () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(prescription.title),
            content: Text(prescription.content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Tutup'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
