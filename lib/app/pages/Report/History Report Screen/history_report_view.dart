import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'package:worker/app/pages/Report/History%20Report%20Screen/widgets/report_client.dart';
import 'package:worker/app/pages/Report/History%20Report%20Screen/widgets/report_worker.dart';
import 'history_report_controller.dart';

class HistoryReportView extends StatelessWidget {
  final HistoryReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7DDCC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: "Report",
              rightIcon: "assets/icons/add_btn.svg",
              rightOnTap: () => Get.toNamed('ReportInput'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h), // Padding di bawah app bar
                  Obx(() {
                    if (controller.reports.isEmpty) {
                      return Center(
                        child: Text(
                          "Belum ada data",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w), // Padding kiri & kanan list
                      child: ListView.builder(
                        shrinkWrap: true, // Agar ListView bisa mengukur ukuran yang tepat
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
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
