import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tes_main/controllers/auth_controller.dart';
import '../routes/app_pages.dart';
// import 'views/home/splash_screen.dart';

void main() async {
  await GetStorage.init();
  Get.put(AuthController());
  runApp(
    DevicePreview(
      defaultDevice: Devices.ios.iPhone13ProMax,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final box = GetStorage();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'B-Medix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BF8E),
          primary: const Color(0xFF00BF8E),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      initialRoute: box.read('token') != null ? AppPages.HOME : AppPages.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
