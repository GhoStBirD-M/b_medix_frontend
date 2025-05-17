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
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // LEFT: TEXT CONTENT
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  discount,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.lightGreen,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
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
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // RIGHT: IMAGE
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageAssetPath,
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
