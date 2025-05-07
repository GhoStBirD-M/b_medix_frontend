import 'cart_item_model.dart';

class Cart {
  final int id;
  final int userId;
  final int isCheckedOut;
  final String createdAt;
  final String updatedAt;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.userId,
    required this.isCheckedOut,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      isCheckedOut: json['is_checked_out'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      items: json['items'] != null
          ? List<CartItem>.from(json['items'].map((x) => CartItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'is_checked_out': isCheckedOut,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'items': items.map((x) => x.toJson()).toList(),
    };
  }

  double get subtotal {
    return items.fold(0, (sum, item) {
      if (item.medicine != null) {
        return sum + (double.parse(item.medicine!.price) * item.quantity);
      }
      return sum;
    });
  }

  double get deliveryFee => 8000;
  
  double get total => subtotal + deliveryFee;
}