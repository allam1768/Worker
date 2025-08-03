import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ReportService {
  static const String baseUrl = "https://hamatech.rplrus.com/api";
  static const String reportEndpoint = "/reports";

  static Future<Map<String, dynamic>> submitReport({
    required String namaPengirim,
    required String area,
    required String informasi,
    required String companyId,
    File? imageFile,
    String? authToken,
  }) async {
    print("🚀 ReportService.submitReport called");
    print("📋 Parameters:");
    print("  - namaPengirim: $namaPengirim");
    print("  - area: $area");
    print("  - informasi: $informasi");
    print("  - companyId: $companyId");
    print("  - imageFile: ${imageFile != null ? 'Present (${imageFile.path})' : 'Not provided'}");
    print("  - authToken: ${authToken != null ? 'Present (${authToken.length} chars)' : 'Not provided'}");

    try {
      print("🌐 Creating multipart request...");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$reportEndpoint'),
      );
      print("✅ Request created for: $baseUrl$reportEndpoint");

      // Add text fields
      print("📝 Adding text fields to request...");
      request.fields['nama_pengirim'] = namaPengirim;
      request.fields['area'] = area;
      request.fields['informasi'] = informasi;
      request.fields['company_id'] = companyId;

      print("✅ Text fields added:");
      request.fields.forEach((key, value) {
        print("  - $key: $value");
      });

      // Add image file if exists
      if (imageFile != null) {
        print("🖼️ Processing image file...");
        print("📁 Image path: ${imageFile.path}");

        // Check if file exists
        bool fileExists = await imageFile.exists();
        print("📋 File exists: $fileExists");

        if (fileExists) {
          var imageLength = await imageFile.length();
          print("📊 Image file size: $imageLength bytes");

          var imageStream = http.ByteStream(imageFile.openRead());
          var filename = 'report_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

          var multipartFile = http.MultipartFile(
            'image', // Make sure this matches your API field name
            imageStream,
            imageLength,
            filename: filename,
          );

          request.files.add(multipartFile);
          print("✅ Image file added to request:");
          print("  - Field name: image");
          print("  - Filename: $filename");
          print("  - Size: $imageLength bytes");
        } else {
          print("❌ Image file does not exist at path: ${imageFile.path}");
          throw Exception("Image file not found");
        }
      } else {
        print("ℹ️ No image file provided");
      }

      // Add headers
      print("📋 Setting up headers...");
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      };

      if (authToken != null && authToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $authToken';
        print("🔐 Authorization header added");
      }

      request.headers.addAll(headers);
      print("✅ Headers added:");
      request.headers.forEach((key, value) {
        // Don't print full auth token for security
        if (key == 'Authorization') {
          print("  - $key: Bearer [TOKEN]");
        } else {
          print("  - $key: $value");
        }
      });

      // Send request
      print("🌐 Sending HTTP request...");
      var response = await request.send();
      print("📨 Response received:");
      print("  - Status Code: ${response.statusCode}");
      print("  - Content Length: ${response.contentLength}");
      print("  - Headers: ${response.headers}");

      var responseBody = await response.stream.bytesToString();
      print("📄 Response body length: ${responseBody.length} characters");
      print("📄 Response body: $responseBody");

      Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = json.decode(responseBody);
        print("✅ JSON decoded successfully");
        print("📊 Parsed response: $jsonResponse");
      } catch (e) {
        print("❌ Failed to decode JSON response: $e");
        print("📄 Raw response that failed to decode: $responseBody");
        throw Exception("Invalid JSON response: $e");
      }

      Map<String, dynamic> result = {
        'statusCode': response.statusCode,
        'data': jsonResponse,
      };

      print("📤 Returning result:");
      print("  - Status Code: ${result['statusCode']}");
      print("  - Data keys: ${jsonResponse.keys.toList()}");

      return result;
    } catch (e) {
      print("💥 Exception in submitReport: $e");
      print("📍 Exception type: ${e.runtimeType}");
      print("🔍 Stack trace: ${StackTrace.current}");
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // Method to get all reports (if needed)
  static Future<Map<String, dynamic>> getReports({
    String? authToken,
    int? page,
    int? limit,
  }) async {
    print("📥 ReportService.getReports called");
    print("📋 Parameters:");
    print("  - authToken: ${authToken != null ? 'Present' : 'Not provided'}");
    print("  - page: $page");
    print("  - limit: $limit");

    try {
      Map<String, String> queryParams = {};
      if (page != null) queryParams['page'] = page.toString();
      if (limit != null) queryParams['limit'] = limit.toString();

      Uri uri = Uri.parse('$baseUrl$reportEndpoint');
      if (queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
        print("🔗 URL with query params: $uri");
      } else {
        print("🔗 URL: $uri");
      }

      Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      if (authToken != null && authToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $authToken';
        print("🔐 Authorization header added");
      }

      print("📋 Request headers:");
      headers.forEach((key, value) {
        if (key == 'Authorization') {
          print("  - $key: Bearer [TOKEN]");
        } else {
          print("  - $key: $value");
        }
      });

      print("🌐 Sending GET request...");
      var response = await http.get(uri, headers: headers);
      print("📨 Response received - Status: ${response.statusCode}");

      var jsonResponse = json.decode(response.body);
      print("📊 Response parsed successfully");

      return {
        'statusCode': response.statusCode,
        'data': jsonResponse,
      };
    } catch (e) {
      print("💥 Exception in getReports: $e");
      throw Exception('Network error: ${e.toString()}');
    }
  }

  // Method to get report by ID (if needed)
  static Future<Map<String, dynamic>> getReportById({
    required String reportId,
    String? authToken,
  }) async {
    print("🔍 ReportService.getReportById called");
    print("📋 Parameters:");
    print("  - reportId: $reportId");
    print("  - authToken: ${authToken != null ? 'Present' : 'Not provided'}");

    try {
      Uri uri = Uri.parse('$baseUrl$reportEndpoint/$reportId');
      print("🔗 URL: $uri");

      Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      if (authToken != null && authToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $authToken';
        print("🔐 Authorization header added");
      }

      print("🌐 Sending GET request...");
      var response = await http.get(uri, headers: headers);
      print("📨 Response received - Status: ${response.statusCode}");

      var jsonResponse = json.decode(response.body);
      print("📊 Response parsed successfully");

      return {
        'statusCode': response.statusCode,
        'data': jsonResponse,
      };
    } catch (e) {
      print("💥 Exception in getReportById: $e");
      throw Exception('Network error: ${e.toString()}');
    }
  }
}