import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../models/orders_model.dart';
import '../utils/constants.dart';
import '../models/cart_model.dart';

class CartService {
  final box = GetStorage();

  Future<Cart> getCart() async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}${Constants.CART_ENDPOINT}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final body = json.decode(response.body);

    if (response.statusCode == 200) {
      return Cart.fromJson(body);
    }
    
    if (response.statusCode == 404 &&
        body is Map<String, dynamic> &&
        body['message'] == 'Cart is empty') {
      return Cart(
        id: 0,
        userId: 0,
        isCheckedOut: 0,
        createdAt: '',
        updatedAt: '',
        items: [],
      );
    }

    throw Exception('Failed to load cart');
  }

  Future<bool> addToCart(int medicineId, int quantity) async {
    final token = box.read('token');
    final response = await http.post(
      Uri.parse('${Constants.BASE_URL}${Constants.CART_ENDPOINT}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'medicine_id': medicineId,
        'quantity': quantity,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  // Update item quantity
  Future<bool> updateCartItemQuantity(int cartItemId, int quantity) async {
    final token = box.read('token');
    final response = await http.put(
      Uri.parse('${Constants.BASE_URL}${Constants.CART_ENDPOINT}/$cartItemId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'quantity': quantity,
      }),
    );

    return response.statusCode == 200;
  }

  // Remove item from cart
  Future<bool> removeFromCart(int cartItemId) async {
    final token = box.read('token');
    final response = await http.delete(
      Uri.parse('${Constants.BASE_URL}${Constants.CART_ENDPOINT}/$cartItemId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response.statusCode == 200;
  }

  Future<Orders> checkoutCart(String paymentMethod) async {
    final token = box.read('token');
    final response = await http.post(
      Uri.parse('${Constants.BASE_URL}${Constants.CHECKOUT_ENDPOINT}'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'payment_method': paymentMethod,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final orderData = data['order'];
      return Orders.fromJson(orderData);
    } else {
      throw Exception(
          json.decode(response.body)['message'] ?? 'Checkout failed');
    }
  }
}
