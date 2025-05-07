import 'package:flutter/material.dart';

class PriceSection extends StatelessWidget {
  final double price;
  final String unit;
  final double discount;
  final double regularPrice;
  
  const PriceSection({
    Key? key,
    required this.price,
    required this.unit,
    required this.discount,
    required this.regularPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        Text(
          '/$unit',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '\$${discount.toStringAsFixed(2)} OFF',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        Text(
          'Reg: \$${regularPrice.toStringAsFixed(2)} USD',
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}