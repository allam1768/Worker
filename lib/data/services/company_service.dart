import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/company_model.dart';

class CompanyService {
  static const String baseUrl = 'https://hamatech.rplrus.com/api';

  static Future<List<CompanyModel>> fetchCompanies() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/companies'),
        headers: {
          'ngrok-skip-browser-warning': '1',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
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