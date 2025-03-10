import 'package:get/get.dart';
import 'package:worker/app/pages/Edit%20Data%20Screen/edit_data_controller.dart';

class EditDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditDataController>(() => EditDataController());
  }
}
