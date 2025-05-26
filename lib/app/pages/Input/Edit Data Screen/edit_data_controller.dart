import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:worker/routes/routes.dart';

class EditDataController extends GetxController {
  RxString selectedCondition = "".obs;
  RxString amount = "".obs;
  RxString information = "".obs;
  RxString conditionError = RxString("");
  RxString amountError = RxString("");
  RxString informationError = RxString("");
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
    // Reset error messages
    conditionError.value = "";
    amountError.value = "";
    informationError.value = "";
    imageError.value = false;

    // Validate each field
    if (selectedCondition.value.isEmpty) {
      conditionError.value = "Condition harus dipilih!";
    }

    if (amount.value.isEmpty) {
      amountError.value = "Amount harus diisi!";
    }

    if (information.value.isEmpty) {
      informationError.value = "Information harus diisi!";
    }

    if (imageFile.value == null) {
      imageError.value = true;
    }

    // Check if form is valid
    bool isValid = selectedCondition.value.isNotEmpty &&
        amount.value.isNotEmpty &&
        information.value.isNotEmpty &&
        imageFile.value != null;

    if (isValid) {
      // TODO: Simpan data ke database atau API
      Future.delayed(Duration(seconds: 1), () {
        Get.offNamed('Detail'); // Kembali ke halaman sebelumnya
      });
    }
  }
}
