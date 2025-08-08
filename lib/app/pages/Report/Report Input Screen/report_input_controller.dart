import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/report_model.dart';
import '../../../../../data/services/report_service.dart';
import '../../Bottom Nav/bottomnav_controller.dart';
import '../../Bottom Nav/bottomnav_view.dart';

class ReportInputController extends GetxController {
  RxString amount = "".obs;
  RxString information = "".obs;
  RxString areaError = "".obs;
  RxString informationError = "".obs;
  Rx<File?> imageFile = Rx<File?>(null);
  RxBool imageError = false.obs;
  RxBool isLoading = false.obs;

  final ReportService _reportService = ReportService();

  Future<void> takePicture() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageError.value = false;
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageError.value = false;
    }
  }

  void validateForm() {
    areaError.value = "";
    informationError.value = "";
    imageError.value = false;

    if (amount.value.isEmpty) areaError.value = "Area harus diisi!";
    if (information.value.isEmpty) informationError.value = "Information harus diisi!";
    if (imageFile.value == null) imageError.value = true;

    bool isValid = amount.value.isNotEmpty &&
        information.value.isNotEmpty &&
        imageFile.value != null;

    if (isValid) {
      submitReport();
    }
  }

  Future<void> submitReport() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      await _reportService.createReportWithImage(
        area: amount.value,
        informasi: information.value,
        imageFile: imageFile.value,
      );

      _showSuccessSnackbar("Report berhasil dibuat");

      // Navigate back to BottomNav and set active tab to HistoryReport (index 2)
      await _navigateToHistoryReport();

    } catch (e) {
      _showErrorSnackbar("Gagal mengirim laporan: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _navigateToHistoryReport() async {
    try {
      // Method 1: Jika BottomNavController sudah ada, update tab-nya dulu
      if (Get.isRegistered<BottomNavController>()) {
        final BottomNavController bottomNavController = Get.find<BottomNavController>();
        bottomNavController.changeTab(2); // Set ke History Report tab
      }

      // Method 2: Navigate dengan delay kecil untuk memastikan controller ready
      await Future.delayed(Duration(milliseconds: 100));

      // Navigate ke BottomNavView
      Get.offAll(() => const BottomNavView());

      // Method 3: Set tab setelah navigation selesai
      await Future.delayed(Duration(milliseconds: 200));

      if (Get.isRegistered<BottomNavController>()) {
        final BottomNavController bottomNavController = Get.find<BottomNavController>();
        bottomNavController.changeTab(2); // Pastikan tab History Report aktif
      } else {
        // Jika controller belum ada, buat baru dan set tab
        final BottomNavController bottomNavController = Get.put(BottomNavController());
        bottomNavController.changeTab(2);
      }

    } catch (e) {
      // Fallback navigation jika ada error
      print("Navigation error: $e");
      Get.offAllNamed("/BottomNav");

      // Coba set tab dengan delay lebih lama
      Future.delayed(Duration(milliseconds: 500), () {
        try {
          final BottomNavController bottomNavController = Get.find<BottomNavController>();
          bottomNavController.changeTab(2);
        } catch (controllerError) {
          print("Controller error: $controllerError");
        }
      });
    }
  }

  void _showSuccessSnackbar(String message) {
    Get.rawSnackbar(
      message: message,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.rawSnackbar(
      message: message,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 4),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
      icon: Icon(Icons.error, color: Colors.white),
    );
  }
}