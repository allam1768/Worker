// alat_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/alat_model.dart';

class AlatService {
  static const String baseUrl = 'https://hamatech.rplrus.com/api';

  // Function to get token from SharedPreferences
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  // Function to get scanned company ID from SharedPreferences
  static Future<String?> getScannedCompanyId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('scanned_company_id');
    } catch (e) {
      print('Error getting scanned company ID: $e');
      return null;
    }
  }

  // Function to get headers with token
  static Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'ngrok-skip-browser-warning': '1',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  // Function to get headers for multipart requests
  static Future<Map<String, String>> getMultipartHeaders() async {
    final token = await getToken();
    return {
      'ngrok-skip-browser-warning': '1',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  static Future<http.Response?> createAlat(
      AlatModel alat, File imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/alat'),
      );

      // Add headers with token
      final headers = await getMultipartHeaders();
      request.headers.addAll(headers);

      request.fields['nama_alat'] = alat.namaAlat;
      request.fields['lokasi'] = alat.lokasi;
      request.fields['detail_lokasi'] = alat.detailLokasi;
      request.fields['pest_type'] = alat.pestType;
      request.fields['kondisi'] = alat.kondisi;
      request.fields['kode_qr'] = alat.kodeQr;

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('alat_image', imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      // Check if unauthorized
      if (response.statusCode == 401) {
        print('❌ Token tidak valid atau sudah expired');
        throw Exception('Token tidak valid atau sudah expired');
      }

      return response;
    } catch (e) {
      print('Error kirim ke API: $e');
      return null;
    }
  }

  static Future<List<AlatModel>> fetchAlat() async {
    try {
      // Get scanned company ID
      final scannedCompanyId = await getScannedCompanyId();

      String apiUrl = '$baseUrl/alat';

      // Add company_id filter if available
      if (scannedCompanyId != null && scannedCompanyId.isNotEmpty) {
        apiUrl += '?company_id=$scannedCompanyId';
        print('Fetching alat with company_id: $scannedCompanyId');
      } else {
        print('No scanned company ID found, fetching all alat');
      }

      // Get headers with token
      final headers = await getHeaders();

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List dataList = jsonData['data'];

        return dataList.map((json) => AlatModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        print('❌ Token tidak valid atau sudah expired');
        throw Exception('Token tidak valid atau sudah expired');
      } else {
        throw Exception('Gagal mengambil data alat (${response.statusCode})');
      }
    } catch (e) {
      print('Error fetching alat: $e');
      throw Exception('Gagal mengambil data alat: $e');
    }
  }

  static Future<http.Response?> deleteAlat(int id) async {
    try {
      // Get headers with token
      final headers = await getHeaders();

      final response = await http.delete(
        Uri.parse('$baseUrl/alat/$id'),
        headers: headers,
      );

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      // Check if unauthorized
      if (response.statusCode == 401) {
        print('❌ Token tidak valid atau sudah expired');
        throw Exception('Token tidak valid atau sudah expired');
      }

      return response;
    } catch (e) {
      print('Error saat menghapus alat: $e');
      return null;
    }
  }

  static Future<http.Response?> updateAlat(int id, AlatModel alat,
      {File? imageFile}) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/alat/$id'),
      );

      // Add headers with token
      final headers = await getMultipartHeaders();
      request.headers.addAll(headers);

      request.fields['nama_alat'] = alat.namaAlat;
      request.fields['lokasi'] = alat.lokasi;
      request.fields['detail_lokasi'] = alat.detailLokasi;
      request.fields['pest_type'] = alat.pestType;
      request.fields['kondisi'] = alat.kondisi;
      request.fields['kode_qr'] = alat.kodeQr;
      request.fields['_method'] = 'PUT';

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('alat_image', imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      // Check if unauthorized
      if (response.statusCode == 401) {
        print('❌ Token tidak valid atau sudah expired');
        throw Exception('Token tidak valid atau sudah expired');
      }

      return response;
    } catch (e) {
      print('Error update ke API: $e');
      return null;
    }
  }

  // Method untuk mengecek apakah token masih valid
  static Future<bool> isTokenValid() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/user'), // endpoint untuk validasi token
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error checking token validity: $e');
      return false;
    }
  }
}