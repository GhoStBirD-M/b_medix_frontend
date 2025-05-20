import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  final List<Widget> children;
  final bool withShadow;

  const InfoContainer({
    super.key,
    required this.children,
    this.withShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}