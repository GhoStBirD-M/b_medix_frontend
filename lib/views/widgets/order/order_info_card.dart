import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/profile/address_controller.dart';
import '../../../controllers/medicine/order_controller.dart';
import '../../../models/medicine/orders_model.dart';
import '../../../views/widgets/order/info_row.dart';

class OrderInfoCard extends StatelessWidget {
  final Orders order;
  final OrderController controller;

  const OrderInfoCard(
      {super.key, required this.order, required this.controller});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());

    return Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StatusBadge(status: order.status),
              ],
            ),
            const Divider(height: 24),
            InfoRow(label: 'Order ID', value: '#${order.id}'),
            InfoRow(
                label: 'Date', value: controller.formatDate(order.createdAt)),
            InfoRow(
                label: 'Payment Method',
                value: order.paymentMethod.toUpperCase()),
            InfoRow(
                label: 'Total Price',
                value:
                    'Rp.${NumberFormat.decimalPattern('id_ID').format(order.totalPrice)}'),
            InfoRow(label: 'Delivery', value: 'Rp. 10.000'),
            InfoRow(
              label: 'Address',
              value: addressController.defaultAddress?.fullAddress ??
                  'No address set',
            ),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(status.toLowerCase());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
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
}
