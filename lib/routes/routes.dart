import 'package:get/get.dart';
import '../app/pages/Input/Data Tools Screen/data_tools_binding.dart';
import '../app/pages/Input/Data Tools Screen/data_tools_view.dart';
import '../app/pages/Input/Detail Screen/detail_binding.dart';
import '../app/pages/Input/Detail Screen/detail_view.dart';
import '../app/pages/Input/Edit Data Screen/edit_data_binding.dart';
import '../app/pages/Input/Edit Data Screen/edit_data_view.dart';
import '../app/pages/Input/History Tools Screen/history_tools_binding.dart';
import '../app/pages/Input/History Tools Screen/history_tools_view.dart';
import '../app/pages/Input/Input Detail Screen/input_detail_binding.dart';
import '../app/pages/Input/Input Detail Screen/input_detail_view.dart';
import '../app/pages/Login Screen/login_screen_binding.dart';
import '../app/pages/Login Screen/login_screen_view.dart';
import '../app/pages/Report/History Report Screen/history_report_binding.dart';
import '../app/pages/Report/History Report Screen/history_report_view.dart';
import '../app/pages/Report/Report Detail Screen/report_detail_binding.dart';
import '../app/pages/Report/Report Detail Screen/report_detail_view.dart';
import '../app/pages/Report/Report Input Screen/report_input_binding.dart';
import '../app/pages/Report/Report Input Screen/report_input_view.dart';
import '../app/pages/Scan/Scan Company Screen/scan_company_binding.dart';
import '../app/pages/Scan/Scan Company Screen/scan_company_view.dart';
import '../app/pages/Scan/Scan Tools Screen/scan_tools_binding.dart';
import '../app/pages/Scan/Scan Tools Screen/scan_tools_view.dart';
import '../app/pages/Splash Screen/spalsh_screen_binding.dart';
import '../app/pages/Splash Screen/spalsh_screen_view.dart';

class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const scanCompany = '/ScanCompany';
  static const allDataTools = '/AllDataTools';
  static const historyTool = '/HistoryTool';
  static const scanTools = '/ScanTools';
  static const inputDetail = '/InputDetail';
  static const detail = '/Detail';
  static const editData = '/EditData';
  static const historyReport = '/HistoryReport';
  static const reportDetail = '/ReportDetail';
  static const reportInput = '/ReportInput';

  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: Routes.scanCompany,
      page: () => ScanCompanyView(),
      binding: ScanCompanyBinding(),
    ),
    GetPage(
      name: Routes.allDataTools,
      page: () => DataToolsView(),
      binding: DataToolsBinding(),
    ),
    GetPage(
      name: Routes.historyTool,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Routes.scanTools,
      page: () => ScanToolsView(),
      binding: ScanToolsBinding(),
    ),
    GetPage(
      name: Routes.inputDetail,
      page: () => InputDetailView(),
      binding: InputDetailBinding(),
    ),
    GetPage(
      name: Routes.detail,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: Routes.editData,
      page: () => EditDataView(),
      binding: EditDataBinding(),
    ),
    GetPage(
      name: Routes.historyReport,
      page: () => HistoryReportView(),
      binding: HistoryReportBinding(),
    ),
    GetPage(
      name: Routes.reportDetail,
      page: () => ReportDetailView(),
      binding: ReportDetailBinding(),
    ),
    GetPage(
      name: Routes.reportInput,
      page: () => ReportInputView(),
      binding: ReportInputBinding(),
    ),
  ];
}
