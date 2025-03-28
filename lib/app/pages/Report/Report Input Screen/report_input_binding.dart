import 'package:get/get.dart';
import 'package:worker/app/pages/Report/Report%20Input%20Screen/report_input_controller.dart';

class ReportInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportInputController>(() => ReportInputController());
  }
}
