import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToolCard extends StatelessWidget {
  final String imagePath;
  final String location;
  final VoidCallback? onTap; // 🔹 Tambahkan fungsi saat card diklik

  const ToolCard({
    Key? key,
    required this.imagePath,
    required this.location,
    this.onTap, // Bisa null kalau nggak dipakai
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // 🔹 Bisa dipencet
      onTap: onTap,
      child: Container(
        width: 342.w,
        height: 172.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.green, width: 2.w),
        ),
        child: Stack(
          children: [
            /// 🔹 Gambar mengisi card sepenuhnya
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Gambar mengikuti ukuran card
                width: double.infinity, // Mengisi lebar penuh
                height: double.infinity, // Mengisi tinggi penuh
              ),
            ),

            /// 🔹 Teks di pojok kiri bawah
            Positioned(
              left: 8.w,
              bottom: 8.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.transparent, // Latar belakang semi transparan
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
