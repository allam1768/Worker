import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryController extends GetxController {
  RxList<Map<String, dynamic>> historyData = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredHistoryData = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // Tool information
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

    // Get arguments passed from ToolCard
    var arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      selectedAlatId.value = arguments['alatId'] ?? '';
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

      final response = await http.get(
        Uri.parse('https://hamatech.rplrus.com/api/catches'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> catchesData = responseData['data']['data'];

        // Transform API data to match the expected format
        List<Map<String, dynamic>> transformedData = catchesData.map((item) {
          // Parse the date from ISO format to dd.MM.yyyy
          DateTime parsedDate = DateTime.parse(item['tanggal']);
          String formattedDate = "${parsedDate.day.toString().padLeft(2, '0')}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.year}";

          // Parse created_at for time
          DateTime createdAt = DateTime.parse(item['created_at']);
          String formattedTime = "${createdAt.hour.toString().padLeft(2, '0')}.${createdAt.minute.toString().padLeft(2, '0')}";

          return {
            "id": item['id'],
            "name": item['alat']['nama_alat'], // Use tool name as display name
            "date": formattedDate,
            "time": formattedTime,
            "alat_id": item['alat_id'].toString(),
            "jenis_hama": item['jenis_hama'],
            "jumlah": item['jumlah'],
            "dicatat_oleh": item['dicatat_oleh'],
            "kondisi": item['kondisi'],
            "catatan": item['catatan'],
            "foto_dokumentasi": item['foto_dokumentasi'],
            "lokasi": item['alat']['lokasi'],
            "detail_lokasi": item['alat']['detail_lokasi'],
            "kode_qr": item['alat']['kode_qr'],
          };
        }).toList();

        historyData.value = transformedData;
        filterDataByAlatId();
      } else {
        errorMessage.value = 'Failed to fetch data: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching data: $e';
      print('Error fetching history data: $e');
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

  // Group filtered data by month
  Map<String, List<Map<String, dynamic>>> groupByMonth() {
    Map<String, List<Map<String, dynamic>>> groupedData = {};

    for (var item in filteredHistoryData) {
      String monthKey = getMonthYearKey(item["date"]);

      if (!groupedData.containsKey(monthKey)) {
        groupedData[monthKey] = [];
      }
      groupedData[monthKey]!.add(item);
    }

    return groupedData;
  }

  // Group data by alat_id instead of month (for general history view)
  Map<String, List<Map<String, dynamic>>> groupByAlatId() {
    Map<String, List<Map<String, dynamic>>> groupedData = {};

    for (var item in historyData) {
      String alatKey = "${item['alat_id']} - ${item['name']}";

      if (!groupedData.containsKey(alatKey)) {
        groupedData[alatKey] = [];
      }
      groupedData[alatKey]!.add(item);
    }

    return groupedData;
  }

  String getMonthYearKey(String date) {
    List<String> splitDate = date.split(".");
    return "${splitDate[1]}.${splitDate[2]}"; // MM.YYYY
  }

  String getMonthName(String monthKey) {
    String month = monthKey.split(".")[0];
    return monthNames[month] ?? "Unknown";
  }

  String getAlatName(String alatKey) {
    return alatKey.split(" - ")[1];
  }

  String getAlatId(String alatKey) {
    return alatKey.split(" - ")[0];
  }

  // Refresh data method
  Future<void> refreshData() async {
    await fetchHistoryData();
  }

  // Get display title for the screen
  String getDisplayTitle() {
    if (selectedToolName.value.isNotEmpty) {
      return selectedToolName.value;
    }
    return "History";
  }

  // Check if we're showing filtered data
  bool get isFiltered => selectedAlatId.value.isNotEmpty;
}