import 'package:get/get.dart';

class DetailController extends GetxController {
  var title = "Fly 01 Utara".obs;
  var namaKaryawan = "Budi".obs;
  var nomorKaryawan = "Nomor Karyawan".obs;
  var tanggalJam = "10.02.2024   09.00".obs;
  var kondisi = "Baik".obs;
  var jumlah = "1000".obs;
  var informasi = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.".obs;

  void editData() {
    print("Edit Clicked");
  }

  void deleteData() {
    print("Delete Clicked");
  }
}
