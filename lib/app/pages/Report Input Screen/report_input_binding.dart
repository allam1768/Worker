import 'package:get/get.dart';
import 'package:worker/app/pages/Edit%20Data%20Screen/edit_data_controller.dart';
import 'package:worker/app/pages/Report%20Input%20Screen/report_input_controller.dart';

class ReportInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportInputController>(() => ReportInputController());
  }
}
