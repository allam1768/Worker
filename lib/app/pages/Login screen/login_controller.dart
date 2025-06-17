import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/login_service.dart';
import '../../../routes/routes.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var loginError = ''.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    isLoading.value = true;
    String name = nameController.text.trim();
    String password = passwordController.text.trim();

    loginError.value = "";

    if (name.isEmpty || password.isEmpty) {
      loginError.value = "Username atau password tidak boleh kosong";
      isLoading.value = false;
      return;
    }

    final result = await LoginService.login(
      name: name,
      password: password,
    );

    isLoading.value = false;

    if (result.success) {
      if (result.user == null) {
        loginError.value = "Username atau password salah";
        return;
      }

      if (result.user!.role.toLowerCase() != 'worker') {
        loginError.value = "Username atau password salah";
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userData', jsonEncode(result.user!.toJson()));

      // Simpan username secara terpisah untuk akses mudah
      await prefs.setString('username', result.user!.name ?? name);

      Get.snackbar("Login Berhasil", result.message,
          snackPosition: SnackPosition.TOP);
      Get.offNamed(Routes.bottomnav);
    } else {
      loginError.value = result.message;
    }
  }

  // Method untuk mendapatkan username dari SharedPreferences
  static Future<String> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'Unknown User';
  }
}