import 'package:get/get.dart';

import 'data_tools_controller.dart';

class DataToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataToolsController>(() => DataToolsController());
  }
}
