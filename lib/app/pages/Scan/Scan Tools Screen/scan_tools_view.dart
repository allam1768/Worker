import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../values/app_color.dart';
import '../../../global-component/CustomAppBar.dart';
import 'scan_tools_controller.dart';

class ScanToolsView extends StatelessWidget {
  const ScanToolsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanToolsController controller = Get.put(ScanToolsController());
    final double scannerSize = MediaQuery.of(context).size.width * 0.8;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAppBar(
              title: "Scan QR",
            ),
            Container(
              width: scannerSize,
              height: scannerSize,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFF59E0B), width: 4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MobileScanner(
                  controller: controller.scannerController,
                  onDetect: controller.handleScanResult,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => IconButton(
                          icon: SvgPicture.asset(
                            controller.isFlashOn.value
                                ? "assets/icons/flash_on.svg"
                                : "assets/icons/flash_off.svg",
                            width: 36,
                          ),
                          onPressed: controller.toggleFlash,
                        )),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
