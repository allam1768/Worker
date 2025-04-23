import 'package:get/get.dart';

class DetailController extends GetxController {
  var title = "Fly 01 Utara".obs;
  var namaKaryawan = "Budi".obs;
  var nomorKaryawan = "Nomor Karyawan".obs;
  var tanggalJam = "22.04.2025   10.50".obs;
  var kondisi = "Baik".obs;
  var jumlah = "1000".obs;
  var informasi = "Lorem ipsum dolor sit amet.".obs;
  var imagePath = "".obs;

  var canEdit = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkEditStatus();
  }

  void checkEditStatus() {
    try {
      var parts = tanggalJam.value.split('   ');
      if (parts.length == 2) {
        String formatted = "${parts[0].split('.').reversed.join('-')} ${parts[1]}";
        DateTime inputTime = DateTime.parse(formatted);
        Duration difference = DateTime.now().difference(inputTime);
        canEdit.value = difference.inHours < 10000;

        print("Sekarang: ${DateTime.now()}");
        print("Waktu input: $inputTime");
        print("Selisih jam: ${difference.inHours}");
        print("Bisa edit? ${canEdit.value}");
      } else {
        canEdit.value = false;
        print("Format tanggal tidak sesuai");
      }
    } catch (e) {
      canEdit.value = false;
      print("Error parsing tanggal: $e");
    }
  }

  void updateDetailData(String newCondition, String newAmount, String newInformation, String newImage) {
    kondisi.value = newCondition;
    jumlah.value = newAmount;
    informasi.value = newInformation;
    imagePath.value = newImage;
  }

  void deleteData() {
    Get.offNamed('HistoryTool');
  }

  void editData() {
    Get.offNamed('EditData');
  }
}
