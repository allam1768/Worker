import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/catch_model.dart';

class CatchService {
  static const String baseUrl = 'https://hamatech.rplrus.com/api';

  Future<CatchModel> createCatch(CatchModel catchData) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/catches'));

      // Add text fields
      request.fields['alat_id'] = catchData.alatId;
      request.fields['jenis_hama'] = catchData.jenisHama;
      request.fields['jumlah'] = catchData.jumlah.toString();
      request.fields['tanggal'] = catchData.tanggal;
      request.fields['dicatat_oleh'] = catchData.dicatatOleh;
      request.fields['kondisi'] = catchData.kondisi;
      request.fields['catatan'] = catchData.catatan;

      // Add image file
      var imageFile = await http.MultipartFile.fromPath(
        'foto_dokumentasi',
        catchData.fotoDokumentasi,
      );
      request.files.add(imageFile);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return CatchModel.fromJson(responseData['data']);
      } else {
        print('Response body: ${response.body}');
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        throw Exception(
            'Failed to create catch record: ${response.statusCode}\nError: ${errorData['message'] ?? errorData}');
      }
    } catch (e) {
      throw Exception('Error creating catch record: $e');
    }
  }

  Future<List<CatchModel>> getCatches() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/catches'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> catchesData = responseData['data'];
        return catchesData.map((json) => CatchModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch catches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching catches: $e');
    }
  }
}
