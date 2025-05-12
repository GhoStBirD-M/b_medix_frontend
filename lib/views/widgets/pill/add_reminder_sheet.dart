import 'package:flutter/material.dart';
import '../../../models/pill_reminder_model.dart';
import '../../widgets/pill/frequency_chip.dart';

class AddReminderSheet extends StatefulWidget {
  final Function(PillReminder) onAddReminder;

  const AddReminderSheet({
    super.key,
    required this.onAddReminder,
  });

  @override
  State<AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<AddReminderSheet> {
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedFrequency = 'Setiap hari';

  @override
  void dispose() {
    _medicineNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            colorScheme: const ColorScheme.light(
              primary: Colors.teal,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _addReminder() {
    if (_medicineNameController.text.trim().isNotEmpty) {
      final newReminder = PillReminder.create(
        medicineName: _medicineNameController.text.trim(),
        time: _selectedTime,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        frequency: _selectedFrequency,
      );

      widget.onAddReminder(newReminder);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan nama obat'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _updateFrequency(String frequency) {
    setState(() {
      _selectedFrequency = frequency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tambah Pengingat Baru',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    TextField(
                      controller: _medicineNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Obat',
                        hintText: 'Masukkan nama obat',
                        prefixIcon: Icon(Icons.medication),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Waktu Minum Obat',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () => _selectTime(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, color: Colors.teal),
                            const SizedBox(width: 12),
                            Text(
                              _selectedTime.format(context),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Frekuensi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        FrequencyChip(
                          label: 'Setiap hari',
                          isSelected: _selectedFrequency == 'Setiap hari',
                          onSelected: _updateFrequency,
                        ),
                        FrequencyChip(
                          label: 'Setiap 12 jam',
                          isSelected: _selectedFrequency == 'Setiap 12 jam',
                          onSelected: _updateFrequency,
                        ),
                        FrequencyChip(
                          label: 'Setiap 8 jam',
                          isSelected: _selectedFrequency == 'Setiap 8 jam',
                          onSelected: _updateFrequency,
                        ),
                        FrequencyChip(
                          label: 'Setiap 6 jam',
                          isSelected: _selectedFrequency == 'Setiap 6 jam',
                          onSelected: _updateFrequency,
                        ),
                        FrequencyChip(
                          label: 'Kustom',
                          isSelected: _selectedFrequency == 'Kustom',
                          onSelected: _updateFrequency,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Catatan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Tambahkan catatan (opsional)',
                        prefixIcon: Icon(Icons.note),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _addReminder,
                        icon: const Icon(Icons.add_alarm),
                        label: const Text('Setel Pengingat'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
