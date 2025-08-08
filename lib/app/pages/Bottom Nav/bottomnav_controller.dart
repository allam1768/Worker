import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/Input/Data%20Tools%20Screen/data_tools_view.dart';
import 'package:worker/app/pages/Report/History%20Report%20Screen/history_report_view.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  var centerButtonScale = 1.0.obs;

  void updateCenterButtonScale(double scale) {
    centerButtonScale.value = scale;
  }

  List<String> icons = [
    "assets/icons/data.svg",
    "assets/icons/qr.svg",
    "assets/icons/report.svg"
  ];

  // Menggunakan List<Widget> langsung seperti dokumen pertama
  final List<Widget> screens = [
    DataToolsView(),
    DataToolsView(), // Placeholder untuk index 1 (center button)
    HistoryReportView(),
  ];

  // Getter untuk kompatibilitas dengan kode lama
  List<Widget> get screensGetter => [
    DataToolsView(),
    HistoryReportView(),
  ];

  // Fungsi navigasi yang dimodifikasi dari dokumen pertama
  void changeTab(int index) {
    if (index == 1) return; // Skip center button

    currentIndex.value = index;
  }

  // Fungsi pengecekan status aktif
  bool isActive(int index) {
    if (index == 1) return false; // Center button never active
    return currentIndex.value == index;
  }

  // Getter untuk selectedIndex (dari dokumen pertama)
  RxInt get selectedIndex => currentIndex;
}