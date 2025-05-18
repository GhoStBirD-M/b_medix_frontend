import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/medicine/order_controller.dart';
import '../../../models/medicine/orders_model.dart';
import '../../../views/order/order_detail_screen.dart';

class OrderCard extends StatelessWidget {
  final Orders order;
  final OrderController controller;

  const OrderCard({super.key, required this.order, required this.controller});

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(order.status.toLowerCase());

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: InkWell(
        onTap: () {
          Get.to(() => OrderDetailScreen(order: order));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'MED-ORDR${order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order.status.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Total: Rp.${order.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Payment Method: ${order.paymentMethod.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Date: ${controller.formatDate(order.createdAt)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${order.items.length} items',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (order.status.toLowerCase() == 'completed' ||
                      order.status.toLowerCase() == 'cancelled')
                    ElevatedButton.icon(
                      onPressed: () => _showDeleteConfirmation(context, order),
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    )
                  else
                    Tooltip(
                      message: 'Only completed orders can be deleted',
                      child: ElevatedButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                          disabledForegroundColor: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'paid':
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.green;
      case 'completed':
        return Colors.lightGreen;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  void _showDeleteConfirmation(BuildContext context, Orders order) {
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
              controller.deleteOrder(order);
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