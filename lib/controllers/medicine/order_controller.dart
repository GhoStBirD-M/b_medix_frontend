import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/medicine/orders_model.dart';
import '../../services/order_service.dart';

class OrderController extends GetxController {
  final OrderService _orderService = OrderService();

  // Observable variables
  final RxList<Orders> orders = <Orders>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // Fetch all orders
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final fetchedOrders = await _orderService.getOrders();
      orders.value = fetchedOrders;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Delete an order if status is "completed"
  Future<void> deleteOrder(Orders order) async {
    // Check if order status is "completed"
    if (order.status.toLowerCase() != "completed" && order.status.toLowerCase() != "cancelled") {
      Get.snackbar(
        'Cannot Delete',
        'Only completed orders can be deleted',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final success = await _orderService.deleteOrder(order.id);

      if (success) {
        // Remove the order from the list
        orders.removeWhere((o) => o.id == order.id);
        Get.snackbar(
          'Success',
          'Order deleted successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete order',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Format date to a readable string
  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
