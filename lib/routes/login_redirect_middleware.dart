import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginRedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    final token = box.read('token');

    // Kalau sudah login, jangan ke login lagi
    if (token != null) {
      return const RouteSettings(name: '/home');
    }

    return null;
  }
}
