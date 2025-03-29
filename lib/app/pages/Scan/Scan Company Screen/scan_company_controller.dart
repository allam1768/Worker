import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCompanyController extends GetxController {
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

  void handleScanResult(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      String scanResult = barcodes.first.rawValue ?? "Tidak terbaca";

      if (isValidHamatechQR(scanResult)) {
        showScanResult(scanResult);
      } else {
        Get.snackbar("Invalid QR", "QR Code ini bukan dari Hamatech.",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  bool isValidHamatechQR(String data) {
    return data.startsWith("Company"); // Sesuaikan formatnya jika berbeda
  }


  void showScanResult(String result) {
    Future.delayed(const Duration(seconds: 0), () {
      Get.offNamed("/AllDataTools");
    });
  }
}
