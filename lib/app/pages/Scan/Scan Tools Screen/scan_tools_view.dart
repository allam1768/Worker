import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'scan_tools_controller.dart';

class ScanToolsView extends StatelessWidget {
  const ScanToolsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanToolsController controller = Get.put(ScanToolsController());

    return Scaffold(
      backgroundColor: const Color(0xFFDDDDDD),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Add Data"),
            const Spacer(),

            // Scanner
            Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.orange, width: 4.w),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: MobileScanner(
                  controller: controller.scannerController,
                  onDetect: controller.handleScanResult,
                ),
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => IconButton(
                  icon: SvgPicture.asset(
                    controller.isFlashOn.value
                        ? "assets/icons/flash_on.svg"
                        : "assets/icons/flash_off.svg",
                    width: 36.w,
                  ),
                  onPressed: controller.toggleFlash,
                )),
                SizedBox(width: 24.w),
                Obx(() => AnimatedRotation(
                  turns: controller.isFrontCamera.value ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      controller.isFrontCamera.value
                          ? "assets/icons/rotate_on.svg"
                          : "assets/icons/rotate_off.svg",
                      width: 36.w,
                    ),
                    onPressed: controller.switchCamera,
                  ),
                )),
              ],
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
