import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/chat_model.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final box = GetStorage();
  // Chat
  Future<List<Chat>> getChatHistory(int doctorId) async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}${Constants.CHAT_ENDPOINT}/$doctorId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((chat) => Chat.fromJson(chat)).toList();
    } else {
      throw Exception('Failed to load chat history: ${response.body}');
    }
  }

  Future<Chat> sendMessage(int doctorId, String message) async {
    final token = box.read('token');
    final response = await http.post(
      Uri.parse('${Constants.BASE_URL}${Constants.CHAT_ENDPOINT}/$doctorId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'message': message,
        'sender': 'user',
      }),
    );

    // print("Status Code: ${response.statusCode}");
    // print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> data = jsonDecode(response.body);
      return Chat.fromJson(data.last);
    } else {
      throw Exception('Failed to send message: ${response.body}');
    }
  }
}
