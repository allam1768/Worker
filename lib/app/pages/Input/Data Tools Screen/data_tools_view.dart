import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'package:worker/app/pages/Input/Data%20Tools%20Screen/widgets/Tool_Card.dart';
import 'data_tools_controller.dart';

class DataToolsView extends StatelessWidget {
  const DataToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    final DataToolsController controller = Get.put(DataToolsController());

    return Scaffold(
      backgroundColor: const Color(0xFFDDDDDD),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Name company",
              rightIcon: "assets/icons/report_icon.svg",
              rightOnTap: controller.goToHistoryReport,
              showBackButton: false,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Expanded(
                      child: Obx(
                            () => controller.tools.isEmpty
                            ? Center(
                          child: Text(
                            "Belum ada alat yg terdaftar",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        )
                            : ListView.builder(
                          itemCount: controller.tools.length,
                          itemBuilder: (context, index) {
                            final tool = controller.tools[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: ToolCard(
                                imagePath: tool["image"]!,
                                location: tool["location"]!,
                                onTap: controller.goToHistoryTool,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
