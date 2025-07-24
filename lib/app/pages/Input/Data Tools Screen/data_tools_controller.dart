import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker/data/models/alat_model.dart';
import 'package:worker/data/services/alat_service.dart';

class DataToolsController extends GetxController {
  final RxList<AlatModel> tools = <AlatModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString companyName = 'Loading...'.obs;
  final RxString scannedCompanyId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadScannedCompanyData(); // Panggil fungsi baru
  }

  /// Ambil company ID dan nama dari SharedPreferences
  Future<void> loadScannedCompanyData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final companyId = prefs.getString('scanned_company_id');
      final companyNamePref = prefs.getString('scanned_company_name');

      if (companyId != null) {
        scannedCompanyId.value = companyId;
        print('Loaded scanned company ID: $companyId');
      }

      if (companyNamePref != null) {
        companyName.value = companyNamePref;
        print('Loaded scanned company name: $companyNamePref');
      }

      await fetchTools(); // Panggil fetch setelah data dimuat
    } catch (e) {
      print('Error loading scanned company data: $e');
    }
  }

  Future<void> fetchTools() async {
    try {
      isLoading.value = true;
      final fetchedTools = await AlatService.fetchAlat();
      tools.assignAll(fetchedTools);

      if (fetchedTools.isEmpty && companyName.value == 'Loading...') {
        companyName.value = scannedCompanyId.value.isNotEmpty
            ? 'Company ID: ${scannedCompanyId.value}'
            : 'All Companies';
      }

      print('Fetched ${fetchedTools.length} tools');
    } catch (e) {
      print('Error fetching tools: $e');
      Get.snackbar(
        'Error',
        'Gagal memuat data alat',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearScannedCompany() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('scanned_company_id');
      await prefs.remove('scanned_company_name');
      scannedCompanyId.value = '';
      companyName.value = 'All Companies';
      await fetchTools(); // Refresh data to show all tools
    } catch (e) {
      print('Error clearing scanned company: $e');
    }
  }

  void goToHistoryTool() {
    Get.toNamed('/HistoryTool');
  }

  void goToScanCompany() {
    Get.toNamed('/ScanCompany');
  }
}
