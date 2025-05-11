import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_main/views/widgets/order/order_info_card.dart';
import 'package:tes_main/views/widgets/order/order_item_list.dart';
import '../../controllers/order_controller.dart';
import '../../models/orders_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final Orders order;
  final OrderController controller = Get.find<OrderController>();

  OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MED-ORDR${order.id}'),
        actions: [
          if (order.status.toLowerCase() == 'completed' ||
              order.status.toLowerCase() == 'cancelled')
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showDeleteConfirmation(context),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderInfoCard(order: order, controller: controller),
            const SizedBox(height: 16),
            OrderItemsList(order: order),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Order'),
        content: const Text('Are you sure you want to delete this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.deleteOrder(order).then((_) {
                if (!controller.orders.contains(order)) {
                  Get.back(); // Go back to orders page
                }
              });
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}