import 'package:get/get.dart';
import 'package:worker/app/pages/Scan/Scan%20Company%20Screen/scan_company_controller.dart';

class ScanCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanCompanyController>(() => ScanCompanyController());
  }
}
