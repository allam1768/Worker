import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/login_service.dart';
import '../../../routes/routes.dart';

final isLoading = false.obs;

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

      // Simpan username secara terpisah untuk kemudahan akses
      await prefs.setString('username', result.user!.name);

      // Simpan token ke SharedPreferences
      if (result.token != null && result.token!.isNotEmpty) {
        await prefs.setString('token', result.token!);
        print('✅ Login berhasil!');
        print('📱 Token berhasil disimpan: ${result.token!}');
        print('👤 User: ${result.user!.name}');
        print('🔑 Role: ${result.user!.role}');
        print('💾 Username tersimpan: ${result.user!.name}');
      } else {
        print('⚠️ Login berhasil tapi token tidak ditemukan atau kosong');
      }
      await prefs.setString('nama', result.user!.name);

      Get.snackbar("Login Berhasil", result.message,
          snackPosition: SnackPosition.TOP);
      Get.offNamed(Routes.scanCompany);
    } else {
      loginError.value = result.message;
    }
  }

  // Method untuk mengambil token dari SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Method untuk mengambil username dari SharedPreferences
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  // Method untuk menghapus token saat logout
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Method untuk menghapus semua data user saat logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('username');
    await prefs.remove('userData');
    await prefs.setBool('isLoggedIn', false);
  }

  // Method untuk mengecek apakah token masih ada
  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  // Method untuk mengecek apakah user sudah login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}