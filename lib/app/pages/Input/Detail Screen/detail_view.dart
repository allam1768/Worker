import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/custom_button_detail.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/info_card.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/info_container.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/widgets/karyawan_card.dart';
import 'package:worker/app/pages/Input/Detail%20Screen/detail_controller.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailController controller = Get.put(DetailController());

    return Scaffold(
      backgroundColor: const Color(0xFFCCD7CD),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Detail"),
            const Spacer(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFBBD4C3),
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
                  Obx(
                        () => Container(
                      height: 180.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: controller.imagePath.value.isEmpty
                            ? Icon(Icons.image, size: 48.sp, color: Colors.white)
                            : Image.network(controller.imagePath.value, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(
                        () => Row(
                      children: [
                        Expanded(child: InfoCard(title: "Condition", value: controller.kondisi.value)),
                        SizedBox(width: 12.w),
                        Expanded(child: InfoCard(title: "Amount", value: controller.jumlah.value)),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() => InfoContainer(title: "Information", content: controller.informasi.value)),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonDetail(
                          icon: Icons.edit,
                          color: Color(0xFF275637),
                          text: 'Edit',
                          onPressed: controller.editData,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomButtonDetail(
                          text: "Delete",
                          icon: Icons.delete,
                          color: Colors.red.shade700,
                          onPressed: controller.deleteData,
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
