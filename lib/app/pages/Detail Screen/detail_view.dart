import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worker/app/global-component/app_bar.dart';
import 'package:worker/app/pages/Detail%20Screen/widgets/custom_button_detail.dart';
import 'package:worker/app/pages/Detail%20Screen/widgets/info_card.dart';
import 'package:worker/app/pages/Detail%20Screen/widgets/info_container.dart';
import 'package:worker/app/pages/Detail%20Screen/widgets/karyawan_card.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fly 01 Utara",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 12.h),
                  const EmployeeCard(
                    name: "Budi",
                    employeeNumber: "Nomor Karyawan",
                    date: "10.02.2024   09.00",
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Icon(Icons.image, size: 48.sp, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const Row(
                    children: [
                      Expanded(child: InfoCard(title: "Condition", value: "Baik")),
                      SizedBox(width: 12),
                      Expanded(child: InfoCard(title: "Amount", value: "1000")),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  const InfoContainer(
                    title: "Information",
                    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          label: "Edit",
                          icon: Icons.edit,
                          color: Color(0xFF275637),
                          onTap: () => print("Edit Clicked"),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomButton(
                          label: "Delete",
                          icon: Icons.delete,
                          color: Colors.red.shade700,
                          onTap: () => print("Delete Clicked"),
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
