import 'package:get/get.dart';
import 'package:tes_main/controllers/chat_controller.dart';
import 'package:tes_main/services/chat_service.dart';

class ChatBinding extends Bindings {
  @override

  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<ChatService>(() => ChatService());
  }
}