import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../models/medicine/medicine_model.dart';

class MedicineService {
  final box = GetStorage();

  // Get all medicines
  Future<List<Medicine>> getMedicines() async {
    try {
      final token = box.read('token');
      final response = await http.get(
        Uri.parse('${Constants.BASE_URL}${Constants.MEDICINE_ENDPOINT}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Medicines medicines = Medicines.fromJson(data);
        return medicines.medicine;
      } else {
        throw Exception('Failed to load medicines: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching medicines: $e');
    }
  }

  // Get medicine details by ID
  Future<Medicine> getMedicineDetails(int id) async {
    try {
      final token = box.read('token');
      final response = await http.get(
          Uri.parse(
              '${Constants.BASE_URL}${Constants.MEDICINE_DETAIL_ENDPOINT}$id'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Medicine.fromJson(data['medicine']);
      } else {
        throw Exception(
            'Failed to load medicine details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching medicine details: $e');
    }
  }
}
