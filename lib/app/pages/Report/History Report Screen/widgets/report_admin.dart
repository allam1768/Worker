import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../values/app_color.dart';

class ReportAdmin extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final String area;
  final String informasi;
  final int reportId;

  const ReportAdmin({
    Key? key,
    required this.name,
    required this.date,
    required this.time,
    required this.area,
    required this.informasi,
    required this.reportId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('🔍 Navigating to ReportDetail with reportId: $reportId'); // Debug log
        Get.toNamed('/ReportDetail', arguments: {'reportId': reportId});
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColor.btomnav,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 14.sp,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    area,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    informasi,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // dorong ke kanan
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14.sp,
                        color: Colors.grey[900],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[900],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}