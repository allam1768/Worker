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
    loadScannedCompanyId();
    fetchTools();
  }

  Future<void> loadScannedCompanyId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final companyId = prefs.getString('scanned_company_id');
      if (companyId != null) {
        scannedCompanyId.value = companyId;
        print('Loaded scanned company ID: $companyId');
      }
    } catch (e) {
      print('Error loading scanned company ID: $e');
    }
  }

  Future<void> fetchTools() async {
    try {
      isLoading.value = true;
      final fetchedTools = await AlatService.fetchAlat();
      tools.assignAll(fetchedTools);

      // Update company name from the first tool if available
      if (fetchedTools.isNotEmpty && fetchedTools.first.company != null) {
        companyName.value = fetchedTools.first.company!.name;
      } else if (scannedCompanyId.value.isNotEmpty) {
        companyName.value = 'Company ID: ${scannedCompanyId.value}';
      } else {
        companyName.value = 'All Companies';
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