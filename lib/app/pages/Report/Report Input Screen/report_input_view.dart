import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/CustomButton.dart';
import 'package:worker/app/global-component/CustomTextField.dart';
import 'package:worker/app/pages/Report/Report%20Input%20Screen/report_input_controller.dart';
import '../../../../values/app_color.dart';
import '../../../global-component/CustomAppBar.dart';
import '../../../global-component/ImageUpload.dart';

class ReportInputView extends StatelessWidget {
  ReportInputView({super.key});

  final ReportInputController controller = Get.put(ReportInputController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                CustomAppBar(title: "Report"),
                SizedBox(height: 22.h),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/report_illustration.svg',
                    width: 200.w,
                    height: 212.h,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: AppColor.backgroundsetengah,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => CustomTextField(
                            label: "Area",
                            onChanged: (value) =>
                                controller.amount.value = value,
                            errorMessage: controller.showError.value &&
                                    controller.amount.value.isEmpty
                                ? "Area harus diisi!"
                                : null,
                          )),
                      SizedBox(height: 15.h),
                      Obx(() => CustomTextField(
                            label: "Information",
                            onChanged: (value) =>
                                controller.information.value = value,
                            errorMessage: controller.showError.value &&
                                    controller.information.value.isEmpty
                                ? "Information harus diisi!"
                                : null,
                          )),
                      SizedBox(height: 15.h),
                      ImageUpload(
                        imageFile: controller.imageFile,
                        imageError: controller.imageError,
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                        text: "Save",
                        backgroundColor: AppColor.btnijo,
                        onPressed: () {
                          controller.validateForm();
                        },
                        fontSize: 16,
                      ),
                      SizedBox(height: 10.h),
                    ],
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
