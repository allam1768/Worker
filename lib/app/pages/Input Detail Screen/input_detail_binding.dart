import 'package:get/get.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/input_detail_controller.dart';

class InputDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputDetailController>(() => InputDetailController());
  }
}
