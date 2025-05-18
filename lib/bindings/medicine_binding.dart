import 'package:get/get.dart';
import '../controllers/medicine/cart_controller.dart';
import '../controllers/medicine/medicine_controller.dart';

class MedicineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineController>(() => MedicineController());
    Get.lazyPut<CartController>(() => CartController());
  }
}