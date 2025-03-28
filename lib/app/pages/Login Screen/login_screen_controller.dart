import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  var isPasswordHidden = true.obs;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var usernameError = "".obs;
  var passwordError = "".obs;
  var loginError = "".obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // Reset semua error
    usernameError.value = "";
    passwordError.value = "";
    loginError.value = "";

    // Cek apakah input kosong
    if (username.isEmpty) {
      usernameError.value = "Username tidak boleh kosong";
    }
    if (password.isEmpty) {
      passwordError.value = "Password tidak boleh kosong";
    }
    if (username.isEmpty || password.isEmpty) {
      return;
    }

    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    if (username == "admin" && password == "admin123") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.offNamed('/ScanCompany');
    } else {
      loginError.value = "Username atau password salah";
    }

    isLoading.value = false;
  }
}
