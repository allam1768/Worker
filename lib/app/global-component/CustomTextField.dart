import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool isNumber;
  final TextInputType? keyboardType;
  final String? errorMessage;
  final String? svgIcon;
  final bool? isPasswordHidden;
  final VoidCallback? onSuffixTap;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.isNumber = false,
    this.keyboardType,
    this.errorMessage,
    this.svgIcon,
    this.isPasswordHidden,
    this.onSuffixTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = errorMessage == null ? const Color(0xFF275637) : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        SizedBox(
          height: 48.h,
          child: TextField(
            controller: controller,
            obscureText: isPassword ? (isPasswordHidden ?? true) : false,
            keyboardType: keyboardType ?? (isNumber ? TextInputType.number : TextInputType.text),
            style: TextStyle(fontSize: 15.sp, color: Colors.black),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText ?? '',
              hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              prefixIcon: svgIcon != null
                  ? Padding(
                padding: EdgeInsets.all(12.w),
                child: SvgPicture.asset(
                  svgIcon!,
                  width: 24.w,
                  height: 24.h,
                ),
              )
                  : null,
              suffixIcon: isPassword
                  ? GestureDetector(
                onTap: onSuffixTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SvgPicture.asset(
                    (isPasswordHidden ?? true)
                        ? 'assets/icons/eye_closed.svg'
                        : 'assets/icons/eye_open.svg',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: borderColor, width: 1.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: borderColor, width: 1.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: borderColor, width: 1.w),
              ),
            ),
          ),
        ),
        if (errorMessage != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 4.w),
            child: Text(
              errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
