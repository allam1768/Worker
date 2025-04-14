import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/values/app_color.dart';
import '../history_tools_controller.dart';
import 'SingleHistoryCard.dart';

class GroupedHistoryCard extends StatelessWidget {
  final String month;
  final List<Map<String, dynamic>> items;
  final RxBool isExpanded = false.obs;
  final HistoryController controller = Get.find();

  GroupedHistoryCard({
    required this.month,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColor.btomnav,
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                isExpanded.value = !isExpanded.value;
              },
              child: Container(
                height: 84.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.getMonthName(month),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AnimatedRotation(
                      turns: isExpanded.value ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.expand_more,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: List.generate(
                    items.length,
                        (index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: index == items.length - 1 ? 0 : 8.h,
                      ),
                      child: SingleHistoryCard(item: items[index]),
                    ),
                  ),
                ),
              ),
              crossFadeState: isExpanded.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
    );
  }
}
