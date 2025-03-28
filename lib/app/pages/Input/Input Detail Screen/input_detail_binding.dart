import 'package:get/get.dart';
import 'input_detail_controller.dart';

class InputDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputDetailController>(() => InputDetailController());
  }
}
