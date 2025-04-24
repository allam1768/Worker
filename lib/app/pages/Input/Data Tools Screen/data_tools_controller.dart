import 'package:get/get.dart';
import 'package:worker/app/pages/Input/History%20Tools%20Screen/history_tools_view.dart';

class DataToolsController extends GetxController {
  final tools = <Map<String, String>>[
    {"image": "assets/images/example.png", "location": "Utara","sub": "sqwqweqwwqrwq"},
    {"image": "assets/images/example.png", "location": "sd","sub": "s"},
    {"image": "assets/images/example.png", "location": "asd","sub": "s"},
    {"image": "assets/images/example.png", "location": "dfsa","sub": "s"},
    {"image": "assets/images/example.png", "location": "fsa","sub": "s"},
    {"image": "assets/images/example.png", "location": "fsd","sub": "s"},
    {"image": "assets/images/example.png", "location": "vsd","sub": "s"},
    {"image": "assets/images/example.png", "location": "sdgs","sub": "s"},



  ].obs;


  void goToHistoryTool() {
    Get.toNamed('/HistoryTool');

  }
}
