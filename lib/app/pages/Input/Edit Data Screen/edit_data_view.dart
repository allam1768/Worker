import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/CustomButton.dart';
import 'package:worker/app/global-component/CustomTextField.dart';
import 'package:worker/app/global-component/app_bar.dart';
import '../../../global-component/ImageUpload.dart';
import 'edit_data_controller.dart';

class EditDataView extends StatelessWidget {
  EditDataView({super.key});

  final EditDataController controller = Get.put(EditDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDDDDD),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Edit Data"),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 250.h,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/input_illustration.svg',
                        width: 310.w,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      width: double.infinity,
                      child: Text(
                        "Fly 01 Utara",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0xFFBBD4C3),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Condition",
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: Text("Baik"),
                                  value: "Baik",
                                  groupValue: controller.selectedCondition.value,
                                  onChanged: controller.setCondition,
                                  activeColor: Colors.orange,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: Text("Rusak"),
                                  value: "Rusak",
                                  groupValue: controller.selectedCondition.value,
                                  onChanged: controller.setCondition,
                                  activeColor: Colors.orange,
                                ),
                              ),
                            ],
                          )),
                          SizedBox(height: 15.h),

                          CustomTextField(
                            label: "Amount",
                            onChanged: controller.setAmount,
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

                          CustomTextField(
                            label: "Information",
                            onChanged: controller.setInformation,
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

                          ImageUploadComponent(
                            imageFile: controller.imageFile,
                            imageError: controller.imageError,
                          ),
                          SizedBox(height: 20.h),

                          CustomButton(
                            text: "Save",
                            color: Color(0xFF275637),
                            onPressed: controller.validateForm,
                            fontSize: 16,
                          ),

                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
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
