
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/cart_controller.dart';

class CartSummary extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              Obx(() => Text(
                    'Rp ${cartController.subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          // Delivery Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              Obx(() => Text(
                    'Rp ${cartController.deliveryFee.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(() => Text(
                    'Rp ${cartController.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 20),
          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0BAB7C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Obx(() => cartController.isUpdating.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
            ),
          ),
        ],
      ),
    );
  }
}