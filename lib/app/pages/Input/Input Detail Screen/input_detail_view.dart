import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/CustomButton.dart';
import 'package:worker/app/global-component/CustomTextField.dart';
import 'package:worker/app/pages/Input/Input%20Detail%20Screen/input_detail_controller.dart';
import '../../../../values/app_color.dart';
import '../../../global-component/CustomAppBar.dart';
import '../../../global-component/ImageUpload.dart';

class InputDetailView extends StatelessWidget {
  InputDetailView({super.key});

  final InputDetailController controller = Get.put(InputDetailController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Nama Tools"),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.3,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/input_illustration.svg',
                        width: screenWidth * 0.75,
                      ),
                    ),
                    Container(
                      color: AppColor.backgroundsetengah,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Condition",
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: screenWidth * 0.015),
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.008,
                                              horizontal: screenWidth * 0.015),
                                          decoration: BoxDecoration(
                                            color: controller.selectedCondition
                                                        .value ==
                                                    "Baik"
                                                ? AppColor.oren
                                                    .withOpacity(0.08)
                                                : Colors.white,
                                            border: Border.all(
                                              color: controller
                                                          .showError.value &&
                                                      controller
                                                          .selectedCondition
                                                          .value
                                                          .isEmpty
                                                  ? Colors.red
                                                  : (controller
                                                              .selectedCondition
                                                              .value ==
                                                          "Baik"
                                                      ? AppColor.oren
                                                      : Colors.grey.shade300),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Radio<String>(
                                                value: "Baik",
                                                groupValue: controller
                                                    .selectedCondition.value,
                                                onChanged:
                                                    controller.setCondition,
                                                activeColor: AppColor.oren,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                visualDensity:
                                                    VisualDensity.compact,
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.01),
                                              Text(
                                                "Baik",
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.035,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: screenWidth * 0.015),
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.008,
                                              horizontal: screenWidth * 0.015),
                                          decoration: BoxDecoration(
                                            color: controller.selectedCondition
                                                        .value ==
                                                    "Rusak"
                                                ? AppColor.oren
                                                    .withOpacity(0.08)
                                                : Colors.white,
                                            border: Border.all(
                                              color: controller
                                                          .showError.value &&
                                                      controller
                                                          .selectedCondition
                                                          .value
                                                          .isEmpty
                                                  ? Colors.red
                                                  : (controller
                                                              .selectedCondition
                                                              .value ==
                                                          "Rusak"
                                                      ? AppColor.oren
                                                      : Colors.grey.shade300),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Radio<String>(
                                                value: "Rusak",
                                                groupValue: controller
                                                    .selectedCondition.value,
                                                onChanged:
                                                    controller.setCondition,
                                                activeColor: AppColor.oren,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                visualDensity:
                                                    VisualDensity.compact,
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.01),
                                              Text(
                                                "Rusak",
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.035,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (controller.showError.value &&
                                      controller
                                          .selectedCondition.value.isEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.02,
                                          top: screenHeight * 0.008),
                                      child: Text(
                                        "Kondisi harus dipilih!",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: screenWidth * 0.03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                ],
                              )),
                          SizedBox(height: screenHeight * 0.02),
                          Obx(() => CustomTextField(
                                label: "Amount",
                                isNumber: true,
                                onChanged: controller.setAmount,
                                errorMessage: controller.showError.value &&
                                        controller.amount.value.isEmpty
                                    ? "Amount harus diisi!"
                                    : null,
                              )),
                          SizedBox(height: screenHeight * 0.02),
                          Obx(() => CustomTextField(
                                label: "Information",
                                onChanged: controller.setInformation,
                                errorMessage: controller.showError.value &&
                                        controller.information.value.isEmpty
                                    ? "Information harus diisi!"
                                    : null,
                              )),
                          SizedBox(height: screenHeight * 0.02),
                          ImageUpload(
                            imageFile: controller.imageFile,
                            imageError: controller.imageError,
                            useBottomSheet: false,
                          ),
                          SizedBox(height: screenHeight * 0.06),
                          CustomButton(
                            text: "Save",
                            backgroundColor: AppColor.btnijo,
                            onPressed: controller.validateForm,
                            fontSize: screenWidth * 0.04,
                          ),
                          SizedBox(height: screenHeight * 0.06),
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
