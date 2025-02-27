import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 2)); // Simulasi splash screen

    if (isLoggedIn) {
      Get.offNamed('/home'); // Arahkan ke home jika sudah login
    } else {
      Get.offNamed('/login'); // Arahkan ke login jika belum login
    }
  }
}
