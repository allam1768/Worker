import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'package:worker/app/pages/Input/History%20Tools%20Screen/widgets/GroupHistoryCard.dart';
import 'package:worker/app/pages/Input/History%20Tools%20Screen/widgets/SingleHistoryCard.dart';

import 'history_tools_controller.dart';


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
             CustomAppBar(
                title: "History",
                rightIcon: "assets/icons/qr_btn.svg",
                rightOnTap: controller.goToScanTools,
            ),

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
