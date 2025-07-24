import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../app/pages/Login screen/login_controller.dart';
import '../models/company_model.dart';

class CompanyService {
  static const String baseUrl = 'https://hamatech.rplrus.com/api';

  // Helper method to get the authorization headers
  static Future<Map<String, String>> _getAuthHeaders() async {
    final token = await LoginController.getToken();
    return {
      'ngrok-skip-browser-warning': '1', // Keep this header if it's necessary for your setup
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<List<CompanyModel>> fetchCompanies() async {
    try {
      final headers = await _getAuthHeaders(); // Use auth headers
      final response = await http.get(
        Uri.parse('$baseUrl/companies'),
        headers: headers, // <-- Updated
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List dataList = jsonData['data'];
        return dataList.map((json) => CompanyModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil data perusahaan (${response.statusCode})');
      }
    } catch (e) {
      print('Error fetching companies: $e');
      throw Exception('Gagal mengambil data perusahaan: $e');
    }
  }
}