import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MedicineCardShimmer extends StatelessWidget {
  const MedicineCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Expanded(
              child: Center(
                child: Container(
                  height: 80,
                  width: 80,
                  color: Colors.grey[300],
                ),
              ),
            ),
            // Text placeholders
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: 40,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
