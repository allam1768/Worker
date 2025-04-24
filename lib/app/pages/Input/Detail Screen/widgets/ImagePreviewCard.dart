import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImagePreviewCard extends StatelessWidget {
  final String imageUrl;
  final String imageTitle;

  const ImagePreviewCard({
    Key? key,
    required this.imageUrl,
    required this.imageTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImagePreview(context, imageUrl);
      },
      child: Container(
        width: double.infinity,
        height: 204.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20.r),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _showImagePreview(BuildContext context, String imageUrl) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent, // Biar nggak ada background putih
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

}
