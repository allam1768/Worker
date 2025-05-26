import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ReportInputController extends GetxController {
  RxString amount = "".obs;
  RxString information = "".obs;
  RxString areaError = RxString("");
  RxString informationError = RxString("");
  Rx<File?> imageFile = Rx<File?>(null);
  RxBool imageError = false.obs;

  Future<void> takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageError.value = false; // reset error kalau udah ambil foto
    }
  }

  void validateForm() {
    // Reset error messages
    areaError.value = "";
    informationError.value = "";
    imageError.value = false;

    // Validate each field
    if (amount.value.isEmpty) {
      areaError.value = "Area harus diisi!";
    }

    if (information.value.isEmpty) {
      informationError.value = "Information harus diisi!";
    }

    if (imageFile.value == null) {
      imageError.value = true;
    }

    // Check if form is valid
    bool isValid = amount.value.isNotEmpty &&
        information.value.isNotEmpty &&
        imageFile.value != null;

    if (isValid) {
      Get.rawSnackbar(
        message: "Data berhasil disimpan",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );

      // TODO: Simpan data ke database atau API
    }
  }
}
