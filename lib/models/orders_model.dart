import 'order_item_model.dart';

class Orders {
  final int id;
  final int userId;
  final double totalPrice;
  final String status;
  final String paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItemModel> items;

  Orders({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json['id'],
      userId: json['user_id'],
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      status: json['status'],
      paymentMethod: json['payment_method'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: (json['items'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
    );
  }
}
