import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import '../routes/app_pages.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final box = GetStorage();

  final Rx<User?> user = Rx<User?>(null);
  final Rx<bool> isLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkUserLoggedIn();
  }

  void checkUserLoggedIn() {
    final userJson = box.read('user');
    if (userJson != null) {
      user.value = User.fromJson(jsonDecode(userJson));
    }
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter email and password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    
    try {
      isLoading.value = true;
      final result = await _authService.login(
        emailController.text,
        passwordController.text,
      );
      user.value = result;
      Get.offAllNamed(AppPages.HOME);
    } catch (e) {
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
      emailController.clear();
      passwordController.clear();
    }
  }

  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }
    try {
      isLoading.value = true;
      final result = await _authService.register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      user.value = result;
      Get.offAllNamed(AppPages.LOGIN);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authService.logout();
      user.value = null;
      Get.offAllNamed(AppPages.LOGIN);
    } catch (e) {
      Get.snackbar('error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
