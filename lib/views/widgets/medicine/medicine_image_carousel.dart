import 'package:flutter/material.dart';

class MedicineImageCarousel extends StatelessWidget {
  final String imagePath;
  final int currentIndex;
  final int totalImages;
  
  const MedicineImageCarousel({
    Key? key,
    required this.imagePath,
    required this.currentIndex,
    required this.totalImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Product Image
        Center(
          child: Image.asset(
            imagePath,
            height: 200,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Pagination Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalImages,
            (index) => Container(
              width: index == currentIndex ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index == currentIndex ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}