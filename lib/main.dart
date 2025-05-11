import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../controllers/home_controller.dart';
import '../routes/app_pages.dart';
import 'models/prescription.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
   if (!kIsWeb) {
    await NotificationService().init(); // <-- jalankan hanya jika bukan Web
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PrescriptionAdapter());
  await Hive.openBox<Prescription>('prescriptions');
  Get.put(HomeController());
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
      initialRoute: AppPages.SPLASH,
      getPages: AppPages.routes,
    );
  }
}
