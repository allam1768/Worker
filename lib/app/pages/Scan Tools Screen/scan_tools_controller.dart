import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanToolsController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = false.obs;

  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
    scannerController.toggleTorch();
  }

  void switchCamera() {
    isFrontCamera.value = !isFrontCamera.value;
    scannerController.switchCamera();
  }

  void onScanResult(String? result) {
    String scanResult = result ?? "Tidak terbaca";
    Get.snackbar("Scan Result", scanResult, snackPosition: SnackPosition.BOTTOM);

    // Timer 5 detik untuk pindah halaman meskipun tidak ada hasil scan
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed("/AllDataTools", arguments: {"result": scanResult});
    });
  }
}
