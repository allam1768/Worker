import 'package:get/get.dart';

class DetailController extends GetxController {
  var title = "Fly 01 Utara".obs;
  var namaKaryawan = "Budi".obs;
  var nomorKaryawan = "Nomor Karyawan".obs;
  var tanggalJam = "10.02.2024   09.00".obs;
  var kondisi = "Baik".obs;
  var jumlah = "1000".obs;
  var informasi = "Lorem ipsum dolor sit amet.".obs;
  var imagePath = "".obs;

  void updateDetailData(String newCondition, String newAmount, String newInformation, String newImage) {
    kondisi.value = newCondition;
    jumlah.value = newAmount;
    informasi.value = newInformation;
    imagePath.value = newImage;
  }
}
