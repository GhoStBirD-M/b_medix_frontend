import 'package:get/get.dart';
import 'package:tes_main/models/chat_model.dart';
import 'package:tes_main/services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _apiService = Get.find<ChatService>();
  
  final RxBool isLoading = false.obs;
  final RxList<Chat> messages = <Chat>[].obs;
  final RxInt doctorId = 0.obs;
  final RxBool isSending = false.obs;

  @override
  void onInit() {
    super.onInit();
    // The doctorId will be set when navigating to the chat page
  }

  void setDoctorId(int id) {
    doctorId.value = id;
    fetchChatHistory();
  }

  Future<void> fetchChatHistory() async {
    try {
      isLoading.value = true;
      final List<Chat> chatHistory = await _apiService.getChatHistory(doctorId.value);
      messages.value = chatHistory;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    
    try {
      isSending.value = true;
      final Chat newMessage = await _apiService.sendMessage(doctorId.value, message);
      messages.add(newMessage);
      
      // Simulate doctor's response after a short delay
      await Future.delayed(const Duration(seconds: 1));
      fetchChatHistory();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isSending.value = false;
    }
  }
}