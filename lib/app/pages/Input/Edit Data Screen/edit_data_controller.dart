import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:worker/routes/routes.dart';

class EditDataController extends GetxController {
  RxString selectedCondition = "".obs;
  RxString amount = "".obs;
  RxString information = "".obs;
  RxBool showError = false.obs;
  RxBool imageError = false.obs;
  Rx<File?> imageFile = Rx<File?>(null);

  void setCondition(String? value) {
    if (value != null) {
      selectedCondition.value = value;
    }
  }

  void setAmount(String value) {
    amount.value = value;
  }

  void setInformation(String value) {
    information.value = value;
  }

  Future<void> takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  void validateForm() {
    bool isInvalid = selectedCondition.value.isEmpty ||
        amount.value.isEmpty ||
        information.value.isEmpty ||
        imageFile.value == null;

    showError.value = isInvalid;
    imageError.value = imageFile.value == null;

    if (!isInvalid) {
      

      // TODO: Simpan data ke database atau API

      Future.delayed(Duration(seconds: 1), () {
        Get.offNamed('Detail'); // Kembali ke halaman sebelumnya
      });
    }
  }
}
