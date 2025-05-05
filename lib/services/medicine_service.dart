import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/medicine_model.dart';

class MedicineService {
  final box = GetStorage();

  Future<List<Medicine>> getMedicine() async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}${Constants.MEDICINE_ENDPOINT}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> medicineList = jsonData['medicine'];
      return medicineList.map((e) => Medicine.fromJson(e)).
      toList();
    } else {
      throw Exception('Failed to load medicines');
    }
  }
}
