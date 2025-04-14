import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ReportInputController extends GetxController {
  RxString selectedCondition = "".obs;
  RxString amount = "".obs;
  RxString information = "".obs;
  RxBool showError = false.obs;

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
    bool isFormEmpty = selectedCondition.value.isEmpty || amount.value.isEmpty || information.value.isEmpty;
    bool isImageEmpty = imageFile.value == null;

    if (isFormEmpty || isImageEmpty) {
      showError.value = isFormEmpty;
      imageError.value = isImageEmpty;
    } else {
      showError.value = false;
      imageError.value = false;

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
