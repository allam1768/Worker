import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker/data/services/company_service.dart';
import 'package:worker/data/models/company_model.dart';

class ScanCompanyController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = false.obs;
  RxList<CompanyModel> companies = <CompanyModel>[].obs;
  RxBool isProcessing = false.obs; // Flag to prevent multiple scans

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }

  Future<void> fetchCompanies() async {
    try {
      final fetchedCompanies = await CompanyService.fetchCompanies();
      companies.assignAll(fetchedCompanies);
    } catch (e) {
      print('Error fetching companies: $e');
      Get.snackbar(
        "Error",
        "Gagal mengambil data perusahaan.",
        snackPosition: SnackPosition.TOP,
      );
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
        Get.snackbar(
          "Error",
          "QR Code tidak dapat dibaca.",
          snackPosition: SnackPosition.TOP,
        );
        isProcessing.value = false;
        return;
      }

      try {
        final CompanyModel? matchedCompany =
        companies.firstWhereOrNull((company) => company.companyQr == qrCode);

        if (matchedCompany != null) {
          print('Scan berhasil! ID Perusahaan: ${matchedCompany.id}, Nama Perusahaan: ${matchedCompany.name}');

          // Save company ID and company name to SharedPreferences immediately
          try {
            final prefs = await SharedPreferences.getInstance();

            // Save company ID
            bool saveIdSuccess = await prefs.setString('scanned_company_id', matchedCompany.id.toString());
            if (!saveIdSuccess) {
              throw Exception('Gagal menyimpan company ID ke SharedPreferences');
            }

            // Save company name
            bool saveNameSuccess = await prefs.setString('scanned_company_name', matchedCompany.name ?? 'Unknown');
            if (!saveNameSuccess) {
              throw Exception('Gagal menyimpan company name ke SharedPreferences');
            }

            print('Company ID ${matchedCompany.id} and name ${matchedCompany.name} saved to SharedPreferences');
          } catch (e) {
            print('Error saving to SharedPreferences: $e');
            Get.snackbar(
              "Error",
              "Gagal menyimpan data perusahaan: $e",
              snackPosition: SnackPosition.TOP,
            );
            isProcessing.value = false;
            return;
          }

          // Pause scanner to prevent further scans
          await scannerController.stop();

          // Navigate to the next screen
          Get.offNamed('/Bottomnav');
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
          "Terjadi kesalahan saat memvalidasi QR Code: $e",
          snackPosition: SnackPosition.TOP,
        );
      } finally {
        isProcessing.value = false;
      }
    } else {
      isProcessing.value = false;
    }
  }
}