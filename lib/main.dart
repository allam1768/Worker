import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worker/app/pages/Data%20Tools%20Screen/data_tools_binding.dart';
import 'package:worker/app/pages/Data%20Tools%20Screen/data_tools_view.dart';
import 'package:worker/app/pages/Login%20Screen/login_screen_binding.dart';
import 'package:worker/app/pages/Login%20Screen/login_screen_view.dart';
import 'package:worker/app/pages/Scan%20Company%20Screen/scan_company_binding.dart';
import 'package:worker/app/pages/Scan%20Company%20Screen/scan_company_view.dart';
import 'app/pages/Splash Screen/spalsh_screen_binding.dart';
import 'app/pages/Splash Screen/spalsh_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 917), // Sesuaikan dengan UI desain awal
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.nunitoTextTheme(),
          ),
          initialRoute: '/splash',
          getPages: [
            GetPage(
              name: '/splash',
              page: () => SplashScreenView(),
              binding: SplashScreenBinding(),
            ),
            GetPage(
              name: '/login',
              page: () => LoginScreenView(),
              binding: LoginScreenBinding(),
            ),
            GetPage(
              name: '/ScanCompany',
              page: () => ScanCompanyView(),
              binding: QRScannerBinding(),
            ),
            GetPage(
              name: '/AllDataTools',
              page: () => DataToolsView(),
              binding: DataToolsBinding(),
            ),
          ],
        );
      },
    );
  }
}
