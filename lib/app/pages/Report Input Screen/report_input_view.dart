import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/CustomButton.dart';
import 'package:worker/app/global-component/CustomTextField.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/input_detail_controller.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/widgets/CustomImageUpload_input.dart';

class ReportInputView extends StatelessWidget {
  ReportInputView({super.key});

  final InputDetailController controller = Get.put(InputDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCD7CD),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Report Input"),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 250.h,
                      color: const Color(0xFFCCD7CD),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/report_illustration.svg',
                          width: 206.w,
                        ),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      color: const Color(0xFFBBD4C3),
                      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            label: "Area",
                            onChanged: (value) => controller.amount.value = value,
                          ),
                          Obx(() => controller.showError.value && controller.amount.value.isEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "Area Harus Di Isi",
                              style: TextStyle(fontSize: 14.sp, color: Colors.red),
                            ),
                          )
                              : SizedBox()),
                          SizedBox(height: 15.h),

                          CustomTextField(
                            label: "Information",
                            onChanged: (value) => controller.information.value = value,
                          ),
                          Obx(() => controller.showError.value && controller.information.value.isEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "Information harus diisi!",
                              style: TextStyle(fontSize: 14.sp, color: Colors.red),
                            ),
                          )
                              : SizedBox()),
                          SizedBox(height: 15.h),

                          ImageUploadComponent(),
                          SizedBox(height: 20.h),

                          CustomButton(
                            text: "Save",
                            onPressed: () {
                              controller.validateForm();
                            },
                            fontSize: 20,
                          ),

                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
