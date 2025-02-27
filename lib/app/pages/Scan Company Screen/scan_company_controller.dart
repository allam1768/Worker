import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCompanyController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();

  var isFlashOn = false.obs;
  var isFrontCamera = false.obs;

  /// Toggle Flash
  void toggleFlash() {
    scannerController.toggleTorch();
    isFlashOn.value = !isFlashOn.value;
  }

  /// Switch Camera
  void switchCamera() {
    scannerController.switchCamera();
    isFrontCamera.value = !isFrontCamera.value;
  }

  /// Handle hasil scan
  void onScanResult(String result) {
    Get.snackbar("Hasil Scan", result);
  }
}
