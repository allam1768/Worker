import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/custom_button_detail.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/info_card.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/info_container.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/karyawan_card.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/detail_controller.dart';

import '../../../../values/app_color.dart';
import '../../../dialogs/ConfirmDeleteDialog.dart';
import '../../../global-component/CustomAppBar.dart';
import '../../../global-component/ImagePreview.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailController controller = Get.put(DetailController());

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Detail"),
            const Spacer(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.backgroundsetengah,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                    controller.title.value,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
                  SizedBox(height: 12.h),
                  Obx(() => EmployeeCard(
                    name: controller.namaKaryawan.value,
                    employeeNumber: controller.nomorKaryawan.value,
                    date: controller.tanggalJam.value,
                  )),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {
                      ImagePreview(context, "assets/images/example.png");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 204.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Icon(Icons.image, color: Colors.white, size: 50.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() => Row(
                    children: [
                      Expanded(
                          child: InfoCard(title: "Condition", value: controller.kondisi.value)),
                      SizedBox(width: 12.w),
                      Expanded(
                          child: InfoCard(title: "Amount", value: controller.jumlah.value)),
                    ],
                  )),
                  SizedBox(height: 12.h),
                  Obx(() => InfoContainer(title: "Information", content: controller.informasi.value)),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      // TOMBOL EDIT MUNCUL KALAU BOLEH EDIT
                      Obx(() => controller.canEdit.value
                          ? Expanded(
                        child: CustomButtonDetail(
                          icon: Icons.edit,
                          color: AppColor.btnijo,
                          text: 'Edit',
                          onPressed: controller.editData,
                        ),
                      )
                          : const SizedBox()),
                      Expanded(
                        child: CustomButtonDetail(
                          text: "Delete",
                          icon: Icons.delete,
                          color: Colors.red.shade700,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => ConfirmDeleteDialog(
                                onCancelTap: () {
                                  Navigator.of(context).pop();
                                },
                                onDeleteTap: () {
                                  Navigator.of(context).pop();
                                  controller.deleteData();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
