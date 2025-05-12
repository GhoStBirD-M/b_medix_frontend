import 'package:flutter/material.dart';
import '../../../models/orders_model.dart';
import '../../../views/widgets/order/order_item_card.dart';

class OrderItemsList extends StatelessWidget {
  final Orders order;

  const OrderItemsList({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Items',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: order.items.length,
          itemBuilder: (context, index) {
            final item = order.items[index];
            return OrderItemCard(item: item);
          },
        ),
      ],
    );
  }
}