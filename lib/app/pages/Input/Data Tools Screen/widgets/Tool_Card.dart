import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToolCard extends StatelessWidget {
  final String imagePath;
  final String location;
  final VoidCallback? onTap;

  const ToolCard({
    super.key,
    required this.imagePath,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 172.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Color(0xFF9BBB9C), width: 2.w),
        ),
        child: Stack(
          children: [
            // Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            Positioned(
              left: 8.w,
              bottom: 8.h,
              child: Text(
                location,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
