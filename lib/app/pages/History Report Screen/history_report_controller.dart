import 'package:get/get.dart';

class HistoryReportController extends GetxController {
  var reports = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void loadInitialData() {
    reports.addAll([
      {
        "name": "Wawan",
        "date": "12.02.2024",
        "time": "12.00",
        "role": "worker", // Worker
      },
      {
        "name": "Wawan",
        "date": "12.02.2024",
        "time": "12.00",
        "role": "client", // Client
      },
    ]);
  }


  void addReport(String name, String date, String time) {
    reports.add({"name": name, "date": date, "time": time});
  }
}
