import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class InputDetailController extends GetxController {
  // Validasi input
  RxString selectedCondition = "".obs;
  RxString amount = "".obs;
  RxString information = "".obs;
  RxBool showError = false.obs;

  // Image Picker
  Rx<File?> imageFile = Rx<File?>(null);

  // Fungsi ambil gambar dari kamera
  Future<void> takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  // Fungsi validasi sebelum simpan
  void validateForm() {
    if (selectedCondition.value.isEmpty || amount.value.isEmpty || information.value.isEmpty) {
      showError.value = true; // Tampilkan error
    } else {
      showError.value = false; // Reset error jika semua sudah diisi
      Get.snackbar("Success", "Data berhasil disimpan",
          backgroundColor: Colors.green, colorText: Colors.white);
      // TODO: Simpan data ke database atau API
    }
  }
}
