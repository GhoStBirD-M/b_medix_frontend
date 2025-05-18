import 'medicine_model.dart';

class CartItem {
  final int id;
  final int cartId;
  final int medicineId;
  final int quantity;
  final String createdAt;
  final String updatedAt;
  final Medicine? medicine;

  CartItem({
    required this.id,
    required this.cartId,
    required this.medicineId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    this.medicine,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cart_id'],
      medicineId: json['medicine_id'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      medicine: json['medicine'] != null ? Medicine.fromJson(json['medicine']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart_id': cartId,
      'medicine_id': medicineId,
      'quantity': quantity,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  CartItem copyWith({
    int? id,
    int? cartId,
    int? medicineId,
    int? quantity,
    String? createdAt,
    String? updatedAt,
    Medicine? medicine,
  }) {
    return CartItem(
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      medicineId: medicineId ?? this.medicineId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      medicine: medicine ?? this.medicine,
    );
  }
}