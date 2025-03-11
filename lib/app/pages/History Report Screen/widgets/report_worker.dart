import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportWorker extends StatelessWidget {
  final String name;
  final String date;
  final String time;

  const ReportWorker({
    Key? key,
    required this.name,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Color(0xFF97B999),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
            bottomLeft: Radius.circular(15.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 14.sp),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
