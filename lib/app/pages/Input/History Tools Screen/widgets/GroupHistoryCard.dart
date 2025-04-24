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
          () => Container(
        // Menggunakan SizedBox.expand untuk membuat lebar infinity
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8.h),  // Menghilangkan margin horizontal
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => isExpanded.toggle(),
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.getMonthName(month),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    AnimatedRotation(
                      turns: isExpanded.value ? 0.5 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade200,
            ),
            AnimatedCrossFade(
              firstChild: SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  children: List.generate(
                    items.length,
                        (index) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: SingleHistoryCard(item: items[index]),
                    ),
                  ),
                ),
              ),
              crossFadeState: isExpanded.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}
