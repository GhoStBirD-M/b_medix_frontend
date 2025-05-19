import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/home/onboarding_controller.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image or Icon placeholder
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.fromBorderSide(BorderSide(color: Colors.teal, width: 2)),
            ),
            child: Icon(
              item.icon,
              size: 80,
              color: Colors.teal.shade600,
            ),
          ),
          const SizedBox(height: 48),
          Text(
            item.title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.teal.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.teal.shade700.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
