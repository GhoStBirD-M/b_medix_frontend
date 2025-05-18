import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MedicineDetailShimmer extends StatelessWidget {
  const MedicineDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image placeholder
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 300,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 24,
              width: 200,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Price
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 24,
              width: 100,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Details header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 18,
              width: 100,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
