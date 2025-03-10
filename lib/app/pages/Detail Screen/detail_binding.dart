import 'package:get/get.dart';
import 'package:worker/app/pages/Detail%20Screen/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}
