import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/prescription.dart';
import '../widgets/profile/prescription_card.dart';
import 'prescription_form_screen.dart';

class PrescriptionListScreen extends StatefulWidget {
  const PrescriptionListScreen({super.key});

  @override
  State<PrescriptionListScreen> createState() => _PrescriptionListScreenState();
}

class _PrescriptionListScreenState extends State<PrescriptionListScreen> {
  late Box<Prescription> prescriptionBox;

  @override
  void initState() {
    super.initState();
    prescriptionBox = Hive.box<Prescription>('prescriptions');
  }

  void _addPrescription(Prescription prescription) {
    prescriptionBox.add(prescription);
  }

  void _goToForm() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PrescriptionFormScreen(onAddPrescription: _addPrescription),
      ),
    );
  }

  void _deletePrescription(int index) {
    prescriptionBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Resep'),
        actions: [
          IconButton(
            onPressed: _goToForm,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: prescriptionBox.listenable(),
        builder: (context, Box<Prescription> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('Belum ada resep.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (ctx, i) {
              final prescription = box.getAt(i);
              return Dismissible(
                key: Key(prescription!.title + i.toString()),
                background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => _deletePrescription(i),
                child: PrescriptionCard(prescription: prescription),
              );
            },
          );
        },
      ),
    );
  }
}
