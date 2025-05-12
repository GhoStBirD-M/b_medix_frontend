import 'medicine_model.dart'; // pastikan path ini sesuai

class OrderItemModel {
  final int id;
  final int orderId;
  final int medicineId;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Medicine medicine;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.medicineId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.medicine,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      orderId: json['order_id'],
      medicineId: json['medicine_id'],
      quantity: json['quantity'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      medicine: Medicine.fromJson(json['medicine']),
    );
  }
}
