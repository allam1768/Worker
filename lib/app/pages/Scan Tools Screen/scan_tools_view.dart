import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:worker/app/pages/Scan%20Tools%20Screen/scan_tools_controller.dart';

class ScanToolsView extends GetView<ScanToolsController> {
  const ScanToolsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCE7DA),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar Custom
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
              child: Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () {
                      Get.offNamed('/HistoryTool');
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

                  SizedBox(width: 10.w),

                  // Title
                  Expanded(
                    child: Text(
                      "Add Data",
                      style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

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
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty) {
                      controller.onScanResult(barcodes.first.rawValue ?? "Tidak terbaca");
                    }
                  },
                ),
              ),
            ),

            const Spacer(),

            // Tombol Flash & Rotate
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
