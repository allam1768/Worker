import 'package:get/get.dart';
import 'package:worker/app/pages/Scan/Scan%20Tools%20Screen/scan_tools_controller.dart';

class ScanToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanToolsController>(() => ScanToolsController());
  }
}


