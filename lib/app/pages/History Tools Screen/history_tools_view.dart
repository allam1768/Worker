import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/History%20Tools%20Screen/history_tools_controller.dart';
import 'package:worker/app/pages/History%20Tools%20Screen/widgets/GroupHistoryCard.dart';
import 'package:worker/app/pages/History%20Tools%20Screen/widgets/SingleHistoryCard.dart';


class HistoryView extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCD7CD),
      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h), // Ubah margin jadi 35.w
              child: Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () {
                      Get.offNamed('/AllDataTools');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      child: SvgPicture.asset(
                        "assets/icons/back_btn.svg",
                        width: 44.w,
                        height: 44.h,
                      ),
                    ),
                  ),

                  // Jarak kecil antara back button dan title
                  SizedBox(width: 10.w),

                  // Title di tengah tetapi tetap dekat ke back button
                  Expanded(
                    child: Text(
                      "History",
                      style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // QR Button
                  GestureDetector(
                    onTap: () {
                      Get.offNamed('ScanTools');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      child: SvgPicture.asset(
                        "assets/icons/qr_btn.svg",
                        width: 44.w,
                        height: 44.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),

// List History
            Expanded(
              child: Obx(() {
                var groupedHistory = controller.groupByMonth();
                var sortedKeys = groupedHistory.keys.toList()..sort((b, a) => a.compareTo(b));

                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: sortedKeys.map((month) {
                    List<Map<String, dynamic>> items = groupedHistory[month]!;

                    return (items.length >= 4)
                        ? GroupedHistoryCard(month: month, items: items)
                        : Column(
                      children: items.map((item) => SingleHistoryCard(item: item)).toList(),
                    );
                  }).toList(),
                );
              }),
            ),

          ],
        ),
      ),
    );
  }
}
