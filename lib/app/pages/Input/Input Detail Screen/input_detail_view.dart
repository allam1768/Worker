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
                      height: screenHeight * 0.2,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/input.svg',
                        width: screenWidth * 0.75,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
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
                                              color: controller.conditionError
                                                      .value.isNotEmpty
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
                                              color: controller.conditionError
                                                      .value.isNotEmpty
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
                                  Obx(() =>
                                      controller.conditionError.value.isNotEmpty
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * 0.02,
                                                  top: screenHeight * 0.008),
                                              child: Text(
                                                controller.conditionError.value,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: screenWidth * 0.03,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink()),
                                ],
                              )),
                          SizedBox(height: screenHeight * 0.01),
                          CustomTextField(
                            label: "Jumlah",
                            onChanged: controller.setJumlah,
                            errorMessage: controller.jumlahError,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          CustomTextField(
                            label: "Jenis Hama",
                            onChanged: controller.setJenisHama,
                            errorMessage: controller.jenisHamaError,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          CustomTextField(
                            label: "Catatan",
                            onChanged: controller.setCatatan,
                            errorMessage: controller.catatanError,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          ImageUpload(
                            imageFile: controller.imageFile,
                            imageError: controller.imageError,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          CustomButton(
                            text: "Simpan",
                            backgroundColor: AppColor.btnoren,
                            onPressed: controller.saveCatch,
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
