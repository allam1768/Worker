import 'package:get/get.dart';
import 'package:worker/app/pages/Splash%20screen/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}