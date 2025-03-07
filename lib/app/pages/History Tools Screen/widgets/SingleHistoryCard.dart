import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleHistoryCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const SingleHistoryCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h), // Sama dengan GroupedHistoryCard
      child: Card(
        color: const Color(0xFF9CBE9D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: SizedBox(
          height: 84.h, // Tinggi card tetap
          width: double.infinity, // Lebar penuh
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w), // Padding dalam ListTile
            title: Text(
              item["name"],
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${item["date"]}   ${item["time"]}",
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ),
      ),
    );
  }
}
