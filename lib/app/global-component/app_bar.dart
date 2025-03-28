import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? rightIcon;
  final VoidCallback? rightOnTap;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.rightIcon,
    this.rightOnTap,
    this.showBackButton = true, // Default selalu muncul
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          // Back Button (Bisa di-hide)
          if (showBackButton)
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(10.w),
                child: SvgPicture.asset(
                  "assets/icons/back_btn.svg",
                  width: 44.w,
                  height: 44.h,
                ),
              ),
            ),

          // Jarak kecil antara back button dan title
          if (showBackButton) SizedBox(width: 10.w),

          // Title
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
          ),

          // Right Button (Opsional)
          if (rightIcon != null && rightOnTap != null)
            GestureDetector(
              onTap: rightOnTap,
              child: Container(
                padding: EdgeInsets.all(10.w),
                child: SvgPicture.asset(
                  rightIcon!,
                  width: 44.w,
                  height: 44.h,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
