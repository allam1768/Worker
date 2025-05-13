import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/login_service.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var loginError = ''.obs;
  var loadingDots = "".obs;

  @override
  void onInit() {
    super.onInit();
    ever(isLoading, (_) {
      if (isLoading.value) {
        _startLoadingAnimation();
      }
    });
  }

  void _startLoadingAnimation() {
    var dotCount = 0;
    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 500));
      if (!isLoading.value) return false;
      dotCount = (dotCount + 1) % 4;
      loadingDots.value = '.' * dotCount;
      return true;
    });
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    String name = nameController.text.trim();
    String password = passwordController.text.trim();

    loginError.value = "";

    if (name.isEmpty || password.isEmpty) {
      loginError.value = "Username atau password tidak boleh kosong";
      return;
    }

    isLoading.value = true;

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

      Get.snackbar("Login Berhasil", result.message,
          snackPosition: SnackPosition.TOP);
      Get.offNamed('/Bottomnav');
    } else {
      loginError.value = result.message;
    }
  }
}
