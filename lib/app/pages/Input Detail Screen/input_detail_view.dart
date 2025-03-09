import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/input_detail_controller.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/widgets/CustomButton_input.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/widgets/CustomImageUpload_input.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/widgets/CustomRadioButton_input.dart';
import 'package:worker/app/pages/Input%20Detail%20Screen/widgets/CustomTextField_input.dart';

class InputDetailView extends StatelessWidget {
  InputDetailView({super.key});

  final InputDetailController controller = Get.put(InputDetailController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250.h,
          color: const Color(0xFFCCD7CD),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFCCD7CD),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: Container(
                color: const Color(0xFFCCD7CD),
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offNamed('/ScanTools');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset(
                          "assets/icons/back_btn.svg",
                          width: 44.w,
                          height: 44.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "Input Detail",
                        style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 250.h,
                    color: const Color(0xFFCCD7CD),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/input_illustration.svg',
                        width: 310.w,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 16.h),
                    color: const Color(0xFFCCD7CD),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fly 01 Utara",
                          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: const Color(0xFFBBD4C3),
                    padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRadioButtonGroup(
                          title: "Condition",
                          options: ["Baik", "Rusak"],
                          selectedValue: controller.selectedCondition,
                          showError: controller.showError,
                        ),

                        SizedBox(height: 15.h),
                        CustomTextFieldInput(
                          label: "Amount",
                          onChanged: (value) => controller.amount.value = value,
                        ),
                        Obx(() => controller.showError.value && controller.amount.value.isEmpty
                            ? Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Text(
                            "Amount harus diisi!",
                            style: TextStyle(fontSize: 14.sp, color: Colors.red),
                          ),
                        )
                            : SizedBox()),
                        SizedBox(height: 15.h),
                        CustomTextFieldInput(
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
                        CustomButtonInput(
                          text: "Save",
                          color: Color(0xFF275637),
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
        ),
      ],
    );
  }
}
