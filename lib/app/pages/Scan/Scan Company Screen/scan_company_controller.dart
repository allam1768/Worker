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
      // Only show snackbar once for fetch error
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          "Error",
          "Gagal mengambil data perusahaan.",
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
        final CompanyModel? matchedCompany =
        companies.firstWhereOrNull((company) => company.companyQr == qrCode);

        if (matchedCompany != null) {
          print('Scan berhasil! ID Perusahaan: ${matchedCompany.id}, Nama Perusahaan: ${matchedCompany.name}');

          // Save company data to SharedPreferences immediately
          try {
            final prefs = await SharedPreferences.getInstance();

            // Save company ID as integer (consistent with CompanyCard)
            bool saveIdSuccess = await prefs.setInt('companyid', matchedCompany.id);
            if (!saveIdSuccess) {
              throw Exception('Gagal menyimpan company ID ke SharedPreferences');
            }

            // Also save company ID as string for backward compatibility (if needed elsewhere)
            bool saveIdStringSuccess = await prefs.setString('scanned_company_id', matchedCompany.id.toString());
            if (!saveIdStringSuccess) {
              throw Exception('Gagal menyimpan company ID string ke SharedPreferences');
            }

            // Save company name
            bool saveNameSuccess = await prefs.setString('scanned_company_name', matchedCompany.name ?? 'Unknown');
            if (!saveNameSuccess) {
              throw Exception('Gagal menyimpan company name ke SharedPreferences');
            }

            print('✅ Company ID ${matchedCompany.id} saved to SharedPreferences as int');
            print('✅ Company ID ${matchedCompany.id} saved to SharedPreferences as string (backward compatibility)');
            print('✅ Company name ${matchedCompany.name} saved to SharedPreferences');

            // Debug: Verifikasi penyimpanan
            final savedIdInt = prefs.getInt('companyid');
            final savedIdString = prefs.getString('scanned_company_id');
            final savedName = prefs.getString('scanned_company_name');
            print('🔍 Verification - Saved Company ID (int): $savedIdInt');
            print('🔍 Verification - Saved Company ID (string): $savedIdString');
            print('🔍 Verification - Saved Company Name: $savedName');

          } catch (e) {
            print('❌ Error saving to SharedPreferences: $e');
            if (!Get.isSnackbarOpen) {
              Get.snackbar(
                "Error",
                "Gagal menyimpan data perusahaan: $e",
                snackPosition: SnackPosition.TOP,
              );
            }
            isProcessing.value = false;
            return;
          }

          // Pause scanner to prevent further scans
          await scannerController.stop();

          // Navigate to the next screen
          Get.offNamed('/Bottomnav');
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
        print('❌ Error validating QR code: $e');
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