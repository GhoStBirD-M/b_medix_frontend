import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/widgets/order/order_card.dart';
import '../../controllers/medicine/order_controller.dart';

class OrdersScreen extends StatelessWidget {
  final controller = Get.find<OrderController>();

  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFD4E6E6),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Get.back()),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.orders.isEmpty) {
          return const Center(
            child: Text('No orders found'),
          );
        }
        return RefreshIndicator(
          onRefresh: () => controller.fetchOrders(),
          child: ListView.builder(
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return OrderCard(order: order, controller: controller);
            },
          ),
        );
      }),
    );
  }
}