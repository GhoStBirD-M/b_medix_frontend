import 'package:flutter/material.dart';

class PromotionBanner extends StatelessWidget {
  final String title;
  final String description;
  final String discount;
  final String buttonText;
  final Color color;
  final String imageAssetPath;
  final VoidCallback onPressed;

  const PromotionBanner({
    super.key,
    required this.title,
    required this.description,
    required this.discount,
    required this.buttonText,
    required this.color,
    required this.imageAssetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Left: Text content
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                Text(
                  discount,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(buttonText),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Right: Image
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageAssetPath,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
