import 'package:get/get.dart';
import 'package:worker/app/pages/Input/History%20Tools%20Screen/history_tools_view.dart';

class DataToolsController extends GetxController {
  final tools = <Map<String, String>>[
    {"image": "assets/images/example.png", "location": "Utara"},
    {"image": "assets/images/example.png", "location": "sd"},
    {"image": "assets/images/example.png", "location": "asd"},
    {"image": "assets/images/example.png", "location": "dfsa"},
    {"image": "assets/images/example.png", "location": "fsa"},
    {"image": "assets/images/example.png", "location": "fsd"},
    {"image": "assets/images/example.png", "location": "vsd"},
    {"image": "assets/images/example.png", "location": "sdgs"},



  ].obs;


  void goToHistoryTool() {
    Get.toNamed('/HistoryTool');

  }
}
