import 'package:flutter/material.dart';

class RatingSection extends StatelessWidget {
  final double rating;
  final int reviewCount;
  
  const RatingSection({
    Key? key,
    required this.rating,
    required this.reviewCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Generate full stars
        ...List.generate(
          rating.floor(),
          (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
        ),
        
        // Add half star if needed
        if (rating - rating.floor() >= 0.5)
          const Icon(Icons.star_half, color: Colors.amber, size: 20),
        
        // Add empty stars to complete 5 stars
        ...List.generate(
          5 - rating.ceil(),
          (index) => Icon(Icons.star_border, color: Colors.amber, size: 20),
        ),
        
        const SizedBox(width: 8),
        Text(
          '$reviewCount Reviews',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}