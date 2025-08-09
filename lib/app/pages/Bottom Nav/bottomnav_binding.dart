import 'package:get/get.dart';
import 'package:worker/app/pages/Input/Data%20Tools%20Screen/data_tools_controller.dart';
import 'package:worker/app/pages/Report/History%20Report%20Screen/history_report_controller.dart';
import 'bottomnav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    // Register BottomNavController
    Get.lazyPut<BottomNavController>(() => BottomNavController());

    // Register controllers for tabs to prevent "not found" errors
    Get.lazyPut<DataToolsController>(() => DataToolsController());
    Get.lazyPut<HistoryReportController>(() => HistoryReportController());
  }
}