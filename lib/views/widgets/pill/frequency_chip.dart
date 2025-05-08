import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class FrequencyChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(String) onSelected;

  const FrequencyChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

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
      selectedColor: AppTheme.primaryColor.withOpacity(0.1),
      checkmarkColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? AppTheme.primaryColor : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
      ),
    );
  }
}
