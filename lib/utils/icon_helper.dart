import 'package:flutter/material.dart';

IconData getIconByName(String name) {
  const iconMap = {
    'shopping_cart_checkout_outlined': Icons.shopping_cart_checkout_outlined,
    'add_shopping_cart_outlined': Icons.add_shopping_cart_outlined,
    'notifications_active_outlined': Icons.notifications_active_outlined,
    // Tambahkan ikon lain sesuai kebutuhan
  };

  return iconMap[name] ?? Icons.notifications_none; // fallback kalau tidak ditemukan
}
