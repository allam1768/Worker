import 'package:get/get.dart';
import 'package:worker/app/pages/History%20Tools%20Screen/history_tools_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
