import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/values/app_color.dart';

class SingleHistoryCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const SingleHistoryCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( vertical: 8.h),
      child: Card(
        color: AppColor.backgroundsetengah,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => Get.toNamed('/Detail'),
          child: SizedBox(
            height: 84.h,
            width: double.infinity,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              title: Text(
                item["name"],
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${item["date"]}   ${item["time"]}",
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
