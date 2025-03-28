import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/CustomTextField.dart';
import 'package:worker/app/global-component/ImagePreviewDialog.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'report_detail_controller.dart';

class ReportDetailView extends StatelessWidget {
  final ReportDetailController controller = Get.put(ReportDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCD7CD),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: "Report Detail"),
                SizedBox(height: 22.h),

                Center(
                  child: SvgPicture.asset(
                    "assets/images/report_illustration.svg",
                    width: 250.w,
                    height: 212.h,
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFBBD4C3),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                ),
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 35.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: "Area",
                      onChanged: (value) => controller.setArea(value),
                    ),
                    SizedBox(height: 15.h),

                    CustomTextField(
                      label: "Information",
                      onChanged: (value) => controller.setInformation(value),
                    ),
                    SizedBox(height: 15.h),

                    Text(
                      "Documentation",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8.h),

                    GestureDetector(
                      onTap: () {
                        showImageDialog(context, "assets/images/example.png");
                      },
                      child: Container(
                        width: double.infinity,
                        height: 204.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Icon(Icons.image, color: Colors.white, size: 50.w),
                        ),
                      ),
                    ),

                    SizedBox(height: 22.h), // Jarak dari bawah layar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
