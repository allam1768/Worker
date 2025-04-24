import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../values/app_color.dart';
import 'bottomnav_controller.dart';
import '../Input/Data%20Tools%20Screen/data_tools_controller.dart';
import '../Scan/Scan%20Tools%20Screen/scan_tools_view.dart';
import '../Scan/Scan%20Tools%20Screen/scan_tools_controller.dart';
import '../Report/History%20Report%20Screen/history_report_controller.dart';

class BottomNavView extends StatelessWidget {
  const BottomNavView({super.key});

  void injectTabControllers() {
    Get.lazyPut(() => DataToolsController());
    Get.lazyPut(() => HistoryReportController());
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    injectTabControllers();

    return Scaffold(
      backgroundColor: AppColor.background,
      resizeToAvoidBottomInset: true,
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: controller.screens,
      )),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Bottom Nav yang ngambang
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColor.btomnav,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 40,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(controller.icons.length, (index) {
                bool isCenter = index == 1;

                if (isCenter) return SizedBox(width: 80); // Kosongin tengah

                return Obx(() {
                  bool isActive = controller.isActive(index);
                  return GestureDetector(
                    onTap: () => controller.changeTab(index),
                    child: Container(
                      height: 55.r,
                      width: 55.r,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColor.btnijo
                            : const Color(0xFFD6D6D6),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          controller.icons[index],
                          color: isActive ? Colors.white70 : Colors.grey,
                          width: 22.w,
                        ),
                      ),
                    ),
                  );
                });
              }),
            ),
          ),

          // Tombol Tengah Scan
          Positioned(
            bottom: 38.h, // Naikin dikit biar di atas bottom nav
            child: GestureDetector(
              onTap: () {
                Get.to(
                  ScanToolsView(),
                  transition: Transition.downToUp,
                  duration: Duration(milliseconds: 200),
                );
              },
              child: Container(
                height: 68.r,
                width: 68.r,
                decoration: BoxDecoration(
                  color: AppColor.oren,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    controller.icons[1],
                    color: Colors.white,
                    width: 28.w,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
