import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/orders_model.dart';

class OrderService {
  final box = GetStorage();
  
  // Get all orders
  Future<List<Orders>> getOrders() async {
    try {
      final token = box.read('token');
      final response = await http.get(
        Uri.parse('${Constants.BASE_URL}${Constants.ORDER_ENDPOINT}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Orders.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }
  
  // Delete an order
  Future<bool> deleteOrder(int orderId) async {
    try {
      final token = box.read('token');
      final response = await http.delete(
        Uri.parse('${Constants.BASE_URL}${Constants.ORDER_ENDPOINT}/$orderId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error deleting order: $e');
    }
  }
}