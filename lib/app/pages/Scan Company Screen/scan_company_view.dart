import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'scan_company_controller.dart';

class ScanCompanyView extends GetView<ScanCompanyController> {
  const ScanCompanyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCE7DA),
      appBar: AppBar(
        title: Text(
          "Scan Qr",
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Spacer(),
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
    );
  }
}