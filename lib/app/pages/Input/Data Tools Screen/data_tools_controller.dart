import 'package:get/get.dart';

class DataToolsController extends GetxController {
  final tools = <Map<String, String>>[
    {"image": "assets/images/example.png", "location": "Utara"},
  ].obs;

  void goToHistoryReport() {
    Get.toNamed('HistoryReport');
  }
  void goToHistoryTool() {
    Get.toNamed('/HistoryTool');
  }
}
