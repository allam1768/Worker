import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worker/app/pages/Data%20Tools%20Screen/widgets/Tool_Card.dart';

class DataToolsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 🔹 Data alat (ubah sesuai kebutuhan)
    final List<Map<String, String>> tools = [
      {"image": "assets/images/example.png", "location": "Utara"},
      // Tambahkan data lain jika perlu
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFD7DDCC), // Warna latar belakang
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 35.w, // 🔹 Jarak kiri biar sejajar dengan konten
        title: Text(
          "Name company",
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 35.w), // 🔹 Jarak kanan ikon
            child: IconButton(
              onPressed: () {
                // Tambahkan aksi jika diperlukan
              },
              icon: SvgPicture.asset(
                "assets/icons/report_icon.svg", // 🔹 Ganti dengan path SVG lu
                width: 44.w,
                height: 44.h,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.w), // 🔹 Jarak kanan-kiri body
        child: Column(
          children: [
            SizedBox(height: 40.h), // 🔹 Jarak antara AppBar & ListView
            Expanded(
              child: tools.isEmpty
                  ? Center(
                child: Text(
                  "Belum ada alat yg terdaftar",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              )
                  : ListView.builder(
                itemCount: tools.length,
                itemBuilder: (context, index) {
                  final tool = tools[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ToolCard(
                      imagePath: tool["image"]!,
                      location: tool["location"]!,
                      onTap: () {
                        print("Tool ${tool["location"]} diklik!");
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
