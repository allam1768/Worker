import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:worker/data/services/alat_service.dart';
import 'package:worker/data/models/alat_model.dart';

class ScanToolsController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = false.obs;
  RxList<AlatModel> tools = <AlatModel>[].obs;
  RxBool isProcessing = false.obs; // Flag to prevent multiple scans

  @override
  void onInit() {
    super.onInit();
    fetchTools();
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }

  Future<void> fetchTools() async {
    try {
      final fetchedTools = await AlatService.fetchAlat();
      tools.assignAll(fetchedTools);
    } catch (e) {
      print('Error fetching tools: $e');
      // Only show snackbar once for fetch error
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          "Error",
          "Gagal mengambil data alat.",
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
    scannerController.toggleTorch();
  }

  void switchCamera() {
    isFrontCamera.value = !isFrontCamera.value;
    scannerController.switchCamera();
  }

  void handleScanResult(BarcodeCapture capture) async {
    if (isProcessing.value) return; // Prevent multiple scans
    isProcessing.value = true;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      String? qrCode = barcodes.first.rawValue;

      if (qrCode == null || qrCode.isEmpty) {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Error",
            "QR Code tidak dapat dibaca.",
            snackPosition: SnackPosition.TOP,
          );
        }
        isProcessing.value = false;
        return;
      }

      try {
        final AlatModel? matchedTool =
        tools.firstWhereOrNull((tool) => tool.kodeQr == qrCode);

        if (matchedTool != null) {
          print('Scan berhasil! ID Alat: ${matchedTool.id}, Nama Alat: ${matchedTool.namaAlat}');

          // Pause scanner to prevent further scans
          await scannerController.stop();

          // Navigate to the next screen
          Get.offNamed('/InputDetail', arguments: {
            'alat_id': matchedTool.id.toString(),
            'nama_alat': matchedTool.namaAlat
          });
        } else {
          if (!Get.isSnackbarOpen) {
            Get.snackbar(
              "QR Code Tidak Valid",
              "QR Code tidak terdaftar dalam sistem.",
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      } catch (e) {
        print('Error validating QR code: $e');
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            "Error",
            "Terjadi kesalahan saat memvalidasi QR Code: $e",
            snackPosition: SnackPosition.TOP,
          );
        }
      } finally {
        isProcessing.value = false;
      }
    } else {
      isProcessing.value = false;
    }
  }
}