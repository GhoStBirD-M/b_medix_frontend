import 'package:get/get.dart';
import '../controllers/home/home_barrel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<MedicineController>(() => MedicineController());
    Get.lazyPut<ArticleController>(() => ArticleController());
  }
}
