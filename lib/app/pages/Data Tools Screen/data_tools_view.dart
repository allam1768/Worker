import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'package:worker/app/pages/Data%20Tools%20Screen/widgets/Tool_Card.dart';

class DataToolsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> tools = [
      {"image": "assets/images/example.png", "location": "Utara"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFD7DDCC),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Name company",
              rightIcon: "assets/icons/report_icon.svg",
              rightOnTap: () {
                Get.offNamed('HistoryReport');
              },
              showBackButton: false,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Expanded(
                      child: tools.isEmpty
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
                        itemCount: tools.length,
                        itemBuilder: (context, index) {
                          final tool = tools[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: ToolCard(
                              imagePath: tool["image"]!,
                              location: tool["location"]!,
                              onTap: () {
                                Get.offNamed('/HistoryTool');
                              },
                            ),
                          );
                        },
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
