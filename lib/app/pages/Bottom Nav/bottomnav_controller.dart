import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/Input/Data%20Tools%20Screen/data_tools_view.dart';
import 'package:worker/app/pages/Report/History%20Report%20Screen/history_report_view.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  List<String> icons = [
    "assets/icons/data.svg",
    "assets/icons/qr.svg",
    "assets/icons/report.svg"
  ];

  List<Widget> get screens => [
    DataToolsView(),
    HistoryReportView(),
  ];

  void changeTab(int index) {
    if (index == 1) return;

    // Index screen-nya digeser karena screen tengah di-skip
    currentIndex.value = index > 1 ? index - 1 : index;
  }

  bool isActive(int index) {
    if (index == 1) return false;
    return currentIndex.value == (index > 1 ? index - 1 : index);
  }
}
