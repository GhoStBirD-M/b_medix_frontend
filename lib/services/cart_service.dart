import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
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

    if (response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cart');
    }
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

  // Checkout
  // Future<bool> checkout() async {
  //   final response = await http.post(
  //     Uri.parse(''),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer YOUR_TOKEN',
  //     },
  //   );

  //   return response.statusCode == 200;
  // }
}