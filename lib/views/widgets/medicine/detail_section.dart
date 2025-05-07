import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  final String details;
  
  const DetailsSection({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          details,
          style: const TextStyle(
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}