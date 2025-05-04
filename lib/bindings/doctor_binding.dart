import 'package:get/get.dart';
import 'package:tes_main/controllers/doctor_controller.dart';

class DoctorBinding extends Bindings {
  @override

  void dependencies() {
    Get.lazyPut<DoctorController>(() => DoctorController());
  }
}