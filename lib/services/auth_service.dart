import 'package:get_storage/get_storage.dart';
import '../../models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import 'dart:convert';

class AuthService {
  final box = GetStorage();

  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${Constants.BASE_URL}${Constants.LOGIN_ENDPOINT}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('RESPONSE BODY: ${response.body}');
      final data = jsonDecode(response.body);
      if (data['user'] == null || data['token'] == null) {
        throw Exception('Data user atau token tidak ditemukan di response');
      }
      final user = User.fromJson(data['user']);

      // Save token
      box.write('token', data['token']);
      print('TOKEN: ${box.read('token')}');
      box.write('user', jsonEncode(data['user']));

      return user;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('${Constants.BASE_URL}${Constants.REGISTER_ENDPOINT}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data['user']);

      box.write('user', jsonEncode(data['user']));
      return user;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to register');
    }
  }

  Future<void> logout() async {
    final token = box.read('token');

    final response = await http.post(
      Uri.parse('${Constants.BASE_URL}${Constants.LOGOUT_ENDPOINT}'),
      headers: {
        'Content-Type': 'Application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      box.remove('token');
      box.remove('user');
    } else {
      throw Exception('Failed to logout');
    }
  }
}
