import 'package:flutter/material.dart';

class FrequencyChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(String) onSelected;

  const FrequencyChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) {
          onSelected(label);
        }
      },
      backgroundColor: Colors.white,
      selectedColor: Colors.teal.withOpacity(0.1),
      checkmarkColor: Colors.teal,
      labelStyle: TextStyle(
        color: isSelected ? Colors.teal : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? Colors.teal : Colors.grey.shade300,
      ),
    );
  }
}
