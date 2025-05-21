import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/date_symbol_data_local.dart';
import '../routes/app_pages.dart';
import 'controllers/home/notification_controller.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id', null);

  await GetStorage.init();
  Get.put(NotificationController());
  
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

  runApp(DevicePreview(
    defaultDevice: Devices.ios.iPhone13ProMax,
    enabled: true,
    builder: (context) => MyApp(),
  ));

  // runApp(MyApp());
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
