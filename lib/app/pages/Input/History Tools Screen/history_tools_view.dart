import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/Input/History%20Tools%20Screen/widgets/GroupHistoryCard.dart';
import 'package:worker/app/pages/Input/History%20Tools%20Screen/widgets/SingleHistoryCard.dart';
import '../../../../values/app_color.dart';
import '../../../global-component/CustomAppBar.dart';
import 'history_tools_controller.dart';

class HistoryToolView extends StatelessWidget {
  final controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: "History"),
            Expanded(
              child: Obx(() {
                var groupedHistory = controller.groupByMonth();
                var sortedKeys = groupedHistory.keys.toList()
                  ..sort((b, a) => a.compareTo(b));

                return controller.historyData.isEmpty
                    ? Center(
                        child: Text(
                          "Belum ada data",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        children: sortedKeys.map((month) {
                          var items = groupedHistory[month]!;

                          return (items.length >= 4)
                              ? GroupedHistoryCard(month: month, items: items)
                              : Column(
                                  children: items
                                      .map((item) =>
                                          SingleHistoryCard(item: item))
                                      .toList(),
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
