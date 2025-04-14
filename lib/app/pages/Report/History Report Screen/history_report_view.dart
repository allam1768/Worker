import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/Report/History%20Report%20Screen/widgets/report_client.dart';
import 'package:worker/app/pages/Report/History%20Report%20Screen/widgets/report_worker.dart';
import '../../../../values/app_color.dart';
import '../../../global-component/CustomAppBar.dart';
import 'history_report_controller.dart';

class HistoryReportView extends StatelessWidget {
  final HistoryReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: "Report",
              showBackButton: false,
              rightIcon: "assets/icons/add_btn.svg",
              rightOnTap: () => Get.toNamed('ReportInput'),
            ),
            SizedBox(height: 10.h), // Jarak setelah AppBar
            Expanded( // Tambahin Expanded biar ListView bisa scroll
              child: Obx(() {
                if (controller.reports.isEmpty) {
                  return Center(
                    child: Text(
                      "Belum ada data",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w), // Biar rapi
                  itemCount: controller.reports.length,
                  itemBuilder: (context, index) {
                    final report = controller.reports[index];
                    final isWorker = report["role"] == "worker";
                    return isWorker
                        ? ReportWorker(
                      name: report["name"]!,
                      date: report["date"]!,
                      time: report["time"]!,
                    )
                        : ReportClient(
                      name: report["name"]!,
                      date: report["date"]!,
                      time: report["time"]!,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
