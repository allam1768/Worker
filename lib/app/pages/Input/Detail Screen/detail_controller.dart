import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailController extends GetxController {
  var title = "".obs;
  var namaKaryawan = "".obs;
  var nomorKaryawan = "".obs;
  var tanggalJam = "".obs;
  var kondisi = "".obs;
  var jumlah = "".obs;
  var informasi = "".obs;
  var imagePath = "assets/images/example.png".obs;
  var jenisHama = "".obs;
  var lokasi = "".obs;
  var detailLokasi = "".obs;
  var kodeQR = "".obs;
  var tanggal = "".obs;
  var namaAlat = "".obs;
  var catchId = 0.obs;

  var canEdit = true.obs;
  var isLoading = false.obs;
  var catchData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadDataFromArguments();
  }

  void loadDataFromArguments() {
    // Get data passed from SingleHistoryCard
    var arguments = Get.arguments;

    if (arguments != null && arguments is Map<String, dynamic>) {
      isLoading.value = true;

      // Store the catch data
      catchData.value = arguments;
      catchId.value = arguments['id'] ?? 0;

      // Fetch detailed data from API
      fetchDetailData(catchId.value);
    } else {
      // Fallback to dummy data if no arguments provided
      loadDummyData();
    }
  }

  Future<void> fetchDetailData(int id) async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse('https://hamatech.rplrus.com/api/catches/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> catchDetail = responseData['data'];

        // Update all observable variables with detailed data
        updateDataFromAPI(catchDetail);
      } else {
        // If API fails, use the data from arguments
        updateDataFromArguments();
      }
    } catch (e) {
      print('Error fetching detail data: $e');
      // If API fails, use the data from arguments
      updateDataFromArguments();
    } finally {
      isLoading.value = false;
    }
  }

  void updateDataFromAPI(Map<String, dynamic> data) {
    // Update observable variables with the received data from API
    title.value = data['alat']['nama_alat'] ?? 'Unknown Tool';
    namaKaryawan.value = data['dicatat_oleh'] ?? 'Unknown';
    nomorKaryawan.value = "ID: ${data['alat_id'] ?? 'N/A'}";

    // Parse tanggal and created_at for better formatting
    String dateStr = data['tanggal'] ?? '';
    String createdAtStr = data['created_at'] ?? '';

    if (dateStr.isNotEmpty && createdAtStr.isNotEmpty) {
      try {
        DateTime date = DateTime.parse(dateStr);
        DateTime createdAt = DateTime.parse(createdAtStr);

        String formattedDate = "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
        String formattedTime = "${createdAt.hour.toString().padLeft(2, '0')}.${createdAt.minute.toString().padLeft(2, '0')}";

        tanggalJam.value = "$formattedDate   $formattedTime";
        tanggal.value = formattedDate;
      } catch (e) {
        tanggalJam.value = "${dateStr}   N/A";
        tanggal.value = dateStr;
      }
    }

    kondisi.value = _formatCondition(data['kondisi'] ?? 'unknown');
    jumlah.value = data['jumlah']?.toString() ?? '0';
    jenisHama.value = data['jenis_hama'] ?? 'Unknown';
    informasi.value = data['catatan'] ?? 'No notes available';

    // Tool information
    if (data['alat'] != null) {
      namaAlat.value = data['alat']['nama_alat'] ?? 'Unknown Tool';
      lokasi.value = data['alat']['lokasi'] ?? 'Unknown location';
      detailLokasi.value = data['alat']['detail_lokasi'] ?? '';
      kodeQR.value = data['alat']['kode_qr'] ?? '';
    }

    // Set image path
    String imageUrl = data['foto_dokumentasi'] ?? '';
    if (imageUrl.isNotEmpty) {
      // If it's a relative path, prepend your base URL
      if (!imageUrl.startsWith('http')) {
        imagePath.value = 'https://hamatech.rplrus.com/storage/$imageUrl';
      } else {
        imagePath.value = imageUrl;
      }
    } else {
      imagePath.value = "assets/images/example.png";
    }

    checkEditStatus();
  }

  void updateDataFromArguments() {
    var arguments = catchData.value;

    // Update observable variables with the received data from arguments
    title.value = arguments['name'] ?? 'Unknown Tool';
    namaKaryawan.value = arguments['dicatat_oleh'] ?? 'Unknown';
    nomorKaryawan.value = "ID: ${arguments['alat_id'] ?? 'N/A'}";
    tanggalJam.value = "${arguments['date'] ?? 'N/A'}   ${arguments['time'] ?? 'N/A'}";
    kondisi.value = _formatCondition(arguments['kondisi'] ?? 'unknown');
    jumlah.value = arguments['jumlah']?.toString() ?? '0';
    jenisHama.value = arguments['jenis_hama'] ?? 'Unknown';
    informasi.value = arguments['catatan'] ?? 'No notes available';
    lokasi.value = arguments['lokasi'] ?? 'Unknown location';
    detailLokasi.value = arguments['detail_lokasi'] ?? '';
    kodeQR.value = arguments['kode_qr'] ?? '';
    tanggal.value = arguments['date'] ?? 'N/A';
    namaAlat.value = arguments['name'] ?? 'Unknown Tool';

    // Set image path
    String imageUrl = arguments['foto_dokumentasi'] ?? '';
    if (imageUrl.isNotEmpty) {
      // If it's a relative path, prepend your base URL
      if (!imageUrl.startsWith('http')) {
        imagePath.value = 'https://hamatech.rplrus.com/storage/$imageUrl';
      } else {
        imagePath.value = imageUrl;
      }
    } else {
      imagePath.value = "assets/images/example.png";
    }

    checkEditStatus();
  }

  void loadDummyData() {
    title.value = "Fly 01 Utara";
    namaKaryawan.value = "Budi";
    nomorKaryawan.value = "Nomor Karyawan";
    tanggalJam.value = "13.05.2025   06.11";
    kondisi.value = "Baik";
    jumlah.value = "1000";
    informasi.value = "Lorem ipsum dolor sit amet.";
    imagePath.value = "assets/images/example.png";
    jenisHama.value = "Lalat Buah";
    lokasi.value = "Kebun Utara";
    detailLokasi.value = "Blok A1";
    kodeQR.value = "FLY001";
    tanggal.value = "13.05.2025";
    namaAlat.value = "Fly 01 Utara";
    checkEditStatus();
  }

  String _formatCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'good':
        return 'Baik';
      case 'broken':
        return 'Rusak';
      case 'maintenance':
        return 'Maintenance';
      default:
        return condition;
    }
  }

  void checkEditStatus() {
    try {
      var parts = tanggalJam.value.split('   ');
      if (parts.length == 2) {
        // Parse the date format dd.MM.yyyy
        String datePart = parts[0];
        String timePart = parts[1];

        List<String> dateComponents = datePart.split('.');
        if (dateComponents.length == 3) {
          String formatted = "${dateComponents[2]}-${dateComponents[1]}-${dateComponents[0]} $timePart";
          DateTime inputTime = DateTime.parse(formatted);
          Duration difference = DateTime.now().difference(inputTime);

          // Allow editing within 24 hours (24 * 60 minutes)
          canEdit.value = difference.inMinutes < (24 * 60);

          print("Current time: ${DateTime.now()}");
          print("Input time: $inputTime");
          print("Difference in minutes: ${difference.inMinutes}");
          print("Can edit? ${canEdit.value}");
        } else {
          canEdit.value = false;
          print("Date format doesn't match expected format");
        }
      } else {
        canEdit.value = false;
        print("Date time format doesn't match expected format");
      }
    } catch (e) {
      canEdit.value = false;
      print("Error parsing date: $e");
    }
  }

  void updateDetailData(String newCondition, String newAmount,
      String newInformation, String newImage) {
    kondisi.value = newCondition;
    jumlah.value = newAmount;
    informasi.value = newInformation;
    imagePath.value = newImage;
  }

  Future<void> deleteData() async {
    try {
      isLoading.value = true;

      final response = await http.delete(
        Uri.parse('https://hamatech.rplrus.com/api/catches/${catchId.value}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.back();
        Get.snackbar(
          'Success',
          'Record deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete record',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error deleting record: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void editData() {
    // Pass the current data to edit screen
    Get.toNamed('/EditData', arguments: catchData.value);
  }

  String getFullImageUrl(String imagePath) {
    if (imagePath.isEmpty) return "assets/images/example.png";
    if (imagePath.startsWith('http')) return imagePath;
    return 'https://hamatech.rplrus.com/storage/$imagePath';
  }

  // Method to refresh data
  Future<void> refreshData() async {
    if (catchId.value > 0) {
      await fetchDetailData(catchId.value);
    }
  }
}