import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class InputDetailController extends GetxController {
  // Field input
  RxString selectedCondition = "".obs;
  RxString amount = "".obs;
  RxString information = "".obs;

  // Error flags
  RxBool showError = false.obs;
  RxBool imageError = false.obs;

  // Gambar
  Rx<File?> imageFile = Rx<File?>(null);

  // Setter
  void setCondition(String? value) {
    selectedCondition.value = value ?? "";
    // Update error state
    showError.value = selectedCondition.value.isEmpty;
  }


  void setAmount(String value) {
    amount.value = value;
  }

  void setInformation(String value) {
    information.value = value;
  }

  // Ambil gambar dari kamera
  Future<void> takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageError.value = false;
    }
  }



  // Getter untuk error message field
  String? get conditionError =>
      showError.value && selectedCondition.value.isEmpty ? 'Kondisi harus dipilih!' : null;

  String? get amountError =>
      showError.value && amount.value.isEmpty ? 'Jumlah tidak boleh kosong!' : null;

  String? get informationError =>
      showError.value && information.value.isEmpty ? 'Informasi harus diisi!' : null;

  bool get isImageEmpty => imageFile.value == null;

  // Validasi form
  void validateForm() {
    bool isInvalid = selectedCondition.value.isEmpty ||
        amount.value.isEmpty ||
        information.value.isEmpty ||
        imageFile.value == null;

    showError.value = isInvalid;
    imageError.value = imageFile.value == null;

    if (!isInvalid) {
      Get.snackbar(
        "Success",
        "Data berhasil disimpan",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // TODO: Simpan data ke database atau API

      Future.delayed(Duration(seconds: 1), () {
        Get.offNamed('/HistoryTool'); // Pindah ke dashboard dan menghapus halaman ini dari stack
      });
    }
  }
}
