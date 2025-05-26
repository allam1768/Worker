import 'package:flutter/material.dart';
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

  // Animasi untuk tombol bottom nav
  Widget _buildNavItem(BuildContext context, int index,
      BottomNavController controller, double screenWidth) {
    bool isActive = controller.isActive(index);
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: ColorTween(
          begin: Colors.grey[300]!,
          end: isActive ? AppColor.btnoren : Colors.transparent!,
        ),
        builder: (context, Color? color, child) {
          return Container(
            height: screenWidth * 0.13,
            width: screenWidth * 0.13,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isActive ? 1.2 : 1.0,
                child: SvgPicture.asset(
                  controller.icons[index],
                  color: isActive ? Colors.white : Colors.grey,
                  width: screenWidth * 0.055,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
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
          // Bottom Nav dengan desain minimalis
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.012),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(controller.icons.length, (index) {
                bool isCenter = index == 1;

                if (isCenter) return SizedBox(width: screenWidth * 0.2);

                return Obx(() =>
                    _buildNavItem(context, index, controller, screenWidth));
              }),
            ),
          ),

          // Tombol Tengah Scan
          Positioned(
            bottom: screenHeight * 0.025,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 200),
                tween: Tween<double>(begin: 1, end: 1),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: GestureDetector(
                      onTapDown: (_) => controller.updateCenterButtonScale(1.1),
                      onTapUp: (_) {
                        controller.updateCenterButtonScale(1.0);
                        Get.to(
                          ScanToolsView(),
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 200),
                        );
                      },
                      onTapCancel: () =>
                          controller.updateCenterButtonScale(1.0),
                      child: Obx(() => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: screenWidth * 0.17,
                            width: screenWidth * 0.17,
                            decoration: BoxDecoration(
                              color: AppColor.btnoren,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.btnoren.withOpacity(0.25),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            transform: Matrix4.identity()
                              ..scale(controller.centerButtonScale.value),
                            child: Center(
                              child: SvgPicture.asset(
                                controller.icons[1],
                                color: Colors.white,
                                width: screenWidth * 0.07,
                              ),
                            ),
                          )),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
