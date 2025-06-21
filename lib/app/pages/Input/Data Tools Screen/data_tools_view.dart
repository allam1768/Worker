import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker/app/pages/Input/Data%20Tools%20Screen/widgets/Tool_Card.dart';
import 'package:worker/values/app_color.dart';
import '../../../global-component/CustomAppBar.dart';
import 'data_tools_controller.dart';
import 'package:worker/data/models/alat_model.dart';

class DataToolsView extends StatefulWidget {
  const DataToolsView({super.key});

  @override
  State<DataToolsView> createState() => _DataToolsViewState();
}

class _DataToolsViewState extends State<DataToolsView> {
  String companyName = 'Name company';

  @override
  void initState() {
    super.initState();
    _loadCompanyName();
  }

  Future<void> _loadCompanyName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedCompanyName = prefs.getString('scanned_company_name');

      if (storedCompanyName != null && storedCompanyName.isNotEmpty) {
        setState(() {
          companyName = storedCompanyName;
        });
      } else {
        // Fallback to arguments if SharedPreferences is empty
        final argumentCompanyName = Get.arguments?['company_name'];
        if (argumentCompanyName != null && argumentCompanyName.isNotEmpty) {
          setState(() {
            companyName = argumentCompanyName;
          });
        }
      }
    } catch (e) {
      print('Error loading company name from SharedPreferences: $e');
      // Fallback to arguments if error occurs
      final argumentCompanyName = Get.arguments?['company_name'];
      if (argumentCompanyName != null && argumentCompanyName.isNotEmpty) {
        setState(() {
          companyName = argumentCompanyName;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final DataToolsController controller = Get.put(DataToolsController());

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: companyName, // Gunakan nama perusahaan dari SharedPreferences
              rightIcon: "",
              rightOnTap: () {},
              showBackButton: false,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Obx(
                      () => controller.isLoading.value && controller.tools.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                    onRefresh: controller.fetchTools,
                    child: controller.tools.isEmpty
                        ? ListView(
                      // Supaya bisa di-pull walau kosong
                      children: [
                        SizedBox(height: 50.h),
                        Center(
                          child: Text(
                            "Belum ada alat yg terdaftar",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    )
                        : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.tools.length,
                      itemBuilder: (context, index) {
                        final AlatModel tool =
                        controller.tools[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: ToolCard(
                            toolName: tool.namaAlat,
                            imagePath: tool.imagePath ?? '',
                            location: tool.lokasi,
                            historyItems: [],
                            locationDetail: tool.detailLokasi,
                            pest_type: tool.pestType,
                            kondisi: tool.kondisi,
                            kode_qr: tool.kodeQr,
                            alatId: tool.id.toString(),
                          ),
                        );
                      },
                    ),
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