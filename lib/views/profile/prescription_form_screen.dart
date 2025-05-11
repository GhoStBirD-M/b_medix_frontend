import 'package:flutter/material.dart';
import '../../models/prescription.dart';

class PrescriptionFormScreen extends StatefulWidget {
  final Function(Prescription) onAddPrescription;

  const PrescriptionFormScreen({required this.onAddPrescription, super.key});

  @override
  State<PrescriptionFormScreen> createState() => _PrescriptionFormScreenState();
}

class _PrescriptionFormScreenState extends State<PrescriptionFormScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _submitForm() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;

    final newPrescription = Prescription(
      id: DateTime.now().toString(),
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now(),
    );

    widget.onAddPrescription(newPrescription);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Resep')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Judul Resep'),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Isi Resep'),
              maxLines: 5,
              controller: _contentController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}
