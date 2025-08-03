import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/services/catch_service.dart';

class HistoryController extends GetxController {
  RxList<Map<String, dynamic>> historyData = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredHistoryData = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxString selectedAlatId = ''.obs;
  RxString selectedToolName = ''.obs;
  RxString selectedLocation = ''.obs;
  RxString selectedLocationDetail = ''.obs;

  Map<String, String> monthNames = {
    "01": "January",
    "02": "February",
    "03": "March",
    "04": "April",
    "05": "May",
    "06": "June",
    "07": "July",
    "08": "August",
    "09": "September",
    "10": "October",
    "11": "November",
    "12": "December",
  };

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  // Method untuk mengambil alat ID dari shared preferences
  Future<String> _getAlatIdFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selected_alat_id') ?? '';
  }

  Future<void> _initializeData() async {
    // Ambil alat ID dari shared preferences
    final alatIdFromPrefs = await _getAlatIdFromPrefs();
    selectedAlatId.value = alatIdFromPrefs;

    // Ambil arguments untuk data lainnya (kecuali alatId)
    var arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      selectedToolName.value = arguments['toolName'] ?? '';
      selectedLocation.value = arguments['location'] ?? '';
      selectedLocationDetail.value = arguments['locationDetail'] ?? '';
    }

    fetchHistoryData();
  }

  Future<void> fetchHistoryData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<Map<String, dynamic>> fetchedData = await CatchService.fetchCatchesData();
      historyData.value = fetchedData;
      filterDataByAlatId();
    } catch (e) {
      errorMessage.value = 'Error fetching data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void filterDataByAlatId() {
    if (selectedAlatId.value.isEmpty) {
      filteredHistoryData.value = historyData;
    } else {
      filteredHistoryData.value = historyData
          .where((item) => item['alat_id'].toString() == selectedAlatId.value)
          .toList();
    }
  }

  Map<String, List<Map<String, dynamic>>> groupByMonth() {
    Map<String, List<Map<String, dynamic>>> groupedData = {};
    for (var item in filteredHistoryData) {
      String monthKey = getMonthYearKey(item["date"]);
      groupedData.putIfAbsent(monthKey, () => []).add(item);
    }
    return groupedData;
  }

  Map<String, List<Map<String, dynamic>>> groupByAlatId() {
    Map<String, List<Map<String, dynamic>>> groupedData = {};
    for (var item in historyData) {
      String alatKey = "${item['alat_id']} - ${item['name']}";
      groupedData.putIfAbsent(alatKey, () => []).add(item);
    }
    return groupedData;
  }

  String getMonthYearKey(String date) {
    List<String> splitDate = date.split(".");
    return "${splitDate[1]}.${splitDate[2]}";
  }

  String getMonthName(String monthKey) {
    String month = monthKey.split(".")[0];
    return monthNames[month] ?? "Unknown";
  }

  String getAlatName(String alatKey) => alatKey.split(" - ")[1];
  String getAlatId(String alatKey) => alatKey.split(" - ")[0];

  Future<void> refreshData() async => await fetchHistoryData();

  String getDisplayTitle() => selectedToolName.value.isNotEmpty ? selectedToolName.value : "History";

  bool get isFiltered => selectedAlatId.value.isNotEmpty;

  // Method untuk memperbarui alat ID dari shared preferences
  Future<void> updateAlatIdFromPrefs() async {
    final alatIdFromPrefs = await _getAlatIdFromPrefs();
    if (alatIdFromPrefs != selectedAlatId.value) {
      selectedAlatId.value = alatIdFromPrefs;
      filterDataByAlatId();
    }
  }
}