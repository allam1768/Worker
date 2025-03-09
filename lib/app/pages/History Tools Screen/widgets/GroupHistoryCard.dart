import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:worker/app/pages/History%20Tools%20Screen/history_tools_controller.dart';
import 'package:worker/app/pages/History%20Tools%20Screen/widgets/SingleHistoryCard.dart';

class GroupedHistoryCard extends StatefulWidget {
  final String month;
  final List<Map<String, dynamic>> items;

  const GroupedHistoryCard({required this.month, required this.items, Key? key}) : super(key: key);

  @override
  _GroupedHistoryCardState createState() => _GroupedHistoryCardState();
}

class _GroupedHistoryCardState extends State<GroupedHistoryCard> {
  bool isExpanded = false;
  final HistoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isExpanded ? const Color(0xFFBBD4C3) : const Color(0xFF9CBE9D),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            // Header Group yang Bisa Diklik
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                height: 84.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.getMonthName(widget.month),
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0, // Animasi rotasi ikon
                      duration: const Duration(milliseconds: 300),
                      child: Icon(Icons.expand_more, size: 24.sp),
                    ),
                  ],
                ),
              ),
            ),

            // Daftar History dengan Animasi
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(), // Saat tertutup
              secondChild: Column(
                children: widget.items.map((item) => SingleHistoryCard(item: item)).toList(),
              ), // Saat terbuka
              crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
