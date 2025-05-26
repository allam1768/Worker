import 'package:get/get.dart';
import 'package:worker/data/models/alat_model.dart';
import 'package:worker/data/services/alat_service.dart';

class DataToolsController extends GetxController {
  final RxList<AlatModel> tools = <AlatModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTools();
  }

  Future<void> fetchTools() async {
    try {
      isLoading.value = true;
      final fetchedTools = await AlatService.fetchAlat();
      tools.assignAll(fetchedTools);
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

  void goToHistoryTool() {
    Get.toNamed('/HistoryTool');
  }
}
