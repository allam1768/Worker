import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:worker/data/services/alat_service.dart';
import 'package:worker/data/models/alat_model.dart';

class ScanToolsController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = false.obs;
  RxList<AlatModel> tools = <AlatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTools();
  }

  Future<void> fetchTools() async {
    try {
      final fetchedTools = await AlatService.fetchAlat();
      tools.assignAll(fetchedTools);
    } catch (e) {
      print('Error fetching tools: $e');
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

  void handleScanResult(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      String qrCode = barcodes.first.rawValue ?? "Tidak terbaca";

      try {
        final AlatModel? matchedTool =
            tools.firstWhereOrNull((tool) => tool.kodeQr == qrCode);

        if (matchedTool != null) {
          print('Scan berhasil! ID Alat: ${matchedTool.id}, Nama Alat: ${matchedTool.namaAlat}');
          Get.offNamed('/InputDetail', arguments: {
            'alat_id': matchedTool.id.toString(),
            'nama_alat': matchedTool.namaAlat
          });
        } else {
          Get.snackbar(
            "QR Code Tidak Valid",
            "QR Code tidak terdaftar dalam sistem.",
            snackPosition: SnackPosition.TOP,
          );
        }
      } catch (e) {
        print('Error validating QR code: $e');
        Get.snackbar(
          "Error",
          "Terjadi kesalahan saat memvalidasi QR Code.",
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }
}
