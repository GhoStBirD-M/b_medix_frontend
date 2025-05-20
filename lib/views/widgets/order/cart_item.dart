import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/medicine/cart_controller.dart';
import '../../../models/medicine/cart_item_model.dart';
import 'package:flutter/material.dart';
import '../../../views/widgets/order/quantity_button.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final CartController cartController = Get.find<CartController>();

  CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          // Medicine Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(item.medicine?.imageUrl ??
                    'https://b-medix.im-fall.my.id/storage/medicines/paracetamol.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Medicine Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.medicine?.name ?? 'Medicine',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${NumberFormat.decimalPattern('id_ID').format(double.parse(item.medicine?.price ?? '0'))}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Quantity Controls
          Row(
            children: [
              QuantityButton(
                icon: Icons.remove,
                onPressed: () => cartController.decrementQuantity(item),
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QuantityButton(
                icon: Icons.add,
                onPressed: () => cartController.incrementQuantity(item),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
