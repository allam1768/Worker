import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void ImagePreview(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 3.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
      );
    },
  );
}
