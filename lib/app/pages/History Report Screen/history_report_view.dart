import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'package:worker/app/pages/History%20Report%20Screen/widgets/report_client.dart';
import 'package:worker/app/pages/History%20Report%20Screen/widgets/report_worker.dart';
import 'history_report_controller.dart';


class HistoryReportView extends StatelessWidget {
  final HistoryReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7DDCC),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "History",
                rightIcon: "assets/icons/add_btn.svg",
                rightOnTap: () => Get.offNamed('ScanTools'),
              ),
              SizedBox(height: 20.h),

              // List History
              Expanded(
                child: Obx(() {
                  if (controller.reports.isEmpty) {
                    return Center(
                      child: Text(
                        "Belum ada data",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.w), // Tambahin padding kiri & kanan
                    child: ListView.builder(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
