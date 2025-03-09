import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:worker/app/pages/Input%20Detail%20Screen/input_detail_controller.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/widgets/CustomButton_input.dart';

class ImageUploadComponent extends StatelessWidget {
  final InputDetailController controller = Get.find<InputDetailController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Documentation",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8.h),
        Obx(() => Container(
          height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: controller.imageFile.value == null
              ? Center(child: Text("No Image", style: TextStyle(fontSize: 16.sp)))
              : ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(controller.imageFile.value!, fit: BoxFit.cover),
          ),
        )),
        SizedBox(height: 16.h),
        CustomButtonInput(
          text: "Take a Picture",
          color: Color(0xFFFFA726),
          onPressed: controller.takePicture,
          fontSize: 15,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
