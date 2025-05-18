import 'package:get/get.dart';
import '../controllers/doctor/doctor_controller.dart';

class DoctorBinding extends Bindings {
  @override

  void dependencies() {
    Get.lazyPut<DoctorController>(() => DoctorController());
  }
}