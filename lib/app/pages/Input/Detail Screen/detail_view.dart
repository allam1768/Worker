import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/ImagePreviewCard.dart';
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
    // Mengambil instance dari DetailController
    final DetailController controller = Get.put(DetailController());

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Nama tools"),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Hero(
                        tag: 'preview_image',
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(15.r),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: ImagePreviewCard(
                              imageUrl: controller.imagePath.value,
                              imageTitle: '',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Obx(() => EmployeeCard(
                                  name: controller.namaKaryawan.value,
                                  employeeNumber:
                                      controller.nomorKaryawan.value,
                                  date: controller.tanggalJam.value,
                                )),
                            Divider(
                                height: 1, color: Colors.grey.withOpacity(0.3)),
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                children: [
                                  Obx(() => InfoContainer(
                                      title: "Information",
                                      content: controller.informasi.value)),
                                  SizedBox(height: 16.h),
                                  Obx(() => Row(
                                        children: [
                                          Expanded(
                                              child: InfoCard(
                                                  title: "Condition",
                                                  value: controller
                                                      .kondisi.value)),
                                          SizedBox(width: 16.w),
                                          Expanded(
                                              child: InfoCard(
                                                  title: "Amount",
                                                  value:
                                                      controller.jumlah.value)),
                                        ],
                                      )),
                                  SizedBox(height: 16.h),
                                  Row(
                                    children: [
                                      Obx(() => controller.canEdit.value
                                          ? Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.w),
                                                child: CustomButtonDetail(
                                                  icon: Icons.edit,
                                                  color: AppColor.btnijo,
                                                  text: 'Edit',
                                                  onPressed:
                                                      controller.editData,
                                                ),
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
                                              builder: (_) =>
                                                  ConfirmDeleteDialog(
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
