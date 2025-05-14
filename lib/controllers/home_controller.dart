import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/user_model.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  final Rx<User?> user = Rx<User?>(null);
  
  @override
  void onInit() {
    super.onInit();
    getUserData();
  }
  
  void getUserData() {
    final userJson = box.read('user');
    if (userJson != null) {
      user.value = User.fromJson(jsonDecode(userJson));
    }
  }
}
