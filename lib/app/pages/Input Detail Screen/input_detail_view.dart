import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/app_bar.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFCCD7CD),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(title: "Input Detail"),
            ),

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
                child: Text(
                  "Fly 01 Utara",
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.black),
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
                    CustomRadioButtonGroup(
                      title: "Condition",
                      options: ["Baik", "Rusak"],
                      selectedValue: controller.selectedCondition,
                      showError: controller.showError,
                    ),
                    SizedBox(height: 15.h),

                    // 🔹 Input Amount
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
    );
  }
}
