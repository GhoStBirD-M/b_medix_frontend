import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/app_pages.dart';
import 'dart:async';

import '../../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        final token = box.read('token');
        if (token != null && token != '') {
          Get.offAllNamed(AppPages.HOME);
        } else {
          Get.offAllNamed(AppPages.LOGIN);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/icon/logo.png',
                fit: BoxFit.cover,
              )
            ),
            const SizedBox(height: 24),
            // App name
            const Text(
              'B-Medix',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            const Text(
              'Personal Health Assistant',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),
            // Loading indicator
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> checkTokenValidity(String token) async {
  try {
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}/check-auth'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}