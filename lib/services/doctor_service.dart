import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tes_main/models/doctor_model.dart';
import 'package:tes_main/utils/constants.dart';
import 'package:http/http.dart' as http;
class DoctorService {
  final box = GetStorage();
  // Doctors
  Future<Doctors> getDoctors() async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}${Constants.DOCTOR_ENDPOINT}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Doctors.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load doctors: ${response.body}');
    }
  }

  Future<Doctor> getDoctor(int id) async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}${Constants.DOCTOR_ENDPOINT}/$id'),
      headers:  {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Doctor.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load doctor: ${response.body}');
    }
  }
}