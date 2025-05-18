import 'package:get/get.dart';
import '../controllers/doctor/chat_controller.dart';
import '../services/chat_service.dart';

class ChatBinding extends Bindings {
  @override

  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<ChatService>(() => ChatService());
  }
}