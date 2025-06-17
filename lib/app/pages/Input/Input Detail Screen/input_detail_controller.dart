import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker/data/models/catch_model.dart';
import 'package:worker/data/services/catch_service.dart';

class InputDetailController extends GetxController {
  final CatchService _catchService = CatchService();
  final String alatId = Get.arguments['alat_id'] ?? '';
  final String namaAlat = Get.arguments['nama_alat'] ?? 'Nama Tools';

  // Form values
  final RxString selectedCondition = ''.obs;
  final RxInt jumlah = 0.obs;
  final RxString jenisHama = ''.obs;
  final RxString catatan = ''.obs;
  final Rx<File?> imageFile = Rx<File?>(null);

  // User info
  final RxString currentUsername = 'Unknown User'.obs;

  // Error states
  final RxString conditionError = ''.obs;
  final RxString jumlahError = ''.obs;
  final RxString jenisHamaError = ''.obs;
  final RxString catatanError = ''.obs;
  final RxBool imageError = false.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  // Load username dari SharedPreferences
  Future<void> loadCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username') ?? 'Unknown User';
      currentUsername.value = username;
    } catch (e) {
      print('Error loading username: $e');
      currentUsername.value = 'Unknown User';
    }
  }

  void setCondition(String? value) {
    if (value != null) selectedCondition.value = value;
  }

  void setJumlah(String value) {
    jumlah.value = value.isNotEmpty ? int.tryParse(value) ?? 0 : 0;
  }

  void setJenisHama(String value) => jenisHama.value = value;

  void setCatatan(String value) => catatan.value = value;

  void setImageFile(File? file) => imageFile.value = file;

  /// Fungsi untuk ambil gambar HANYA dari kamera
  Future<void> takePicture() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80, // Kompres gambar untuk menghemat storage
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
        imageError.value = false;
      } else {
        // User membatalkan pengambilan foto
        Get.snackbar(
          'Info',
          'Pengambilan foto dibatalkan',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      imageError.value = true;
      Get.snackbar(
        'Error',
        'Gagal membuka kamera: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  /// Fungsi untuk menghapus gambar yang sudah diambil
  void removeImage() {
    imageFile.value = null;
    imageError.value = false;
  }

  bool validateInputs() {
    bool isValid = true;

    if (selectedCondition.isEmpty) {
      conditionError.value = 'Kondisi harus dipilih!';
      isValid = false;
    } else {
      conditionError.value = '';
    }

    if (jumlah.value <= 0) {
      jumlahError.value = 'Jumlah harus lebih dari 0!';
      isValid = false;
    } else {
      jumlahError.value = '';
    }

    if (jenisHama.isEmpty) {
      jenisHamaError.value = 'Jenis hama harus diisi!';
      isValid = false;
    } else {
      jenisHamaError.value = '';
    }

    if (catatan.isEmpty) {
      catatanError.value = 'Catatan harus diisi!';
      isValid = false;
    } else {
      catatanError.value = '';
    }

    if (imageFile.value == null) {
      imageError.value = true;
      isValid = false;
    } else {
      imageError.value = false;
    }

    return isValid;
  }

  Future<void> saveCatch() async {
    if (!validateInputs()) return;

    isLoading.value = true;

    try {
      final now = DateTime.now();
      final formattedDate =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

      final catchData = CatchModel(
        alatId: alatId,
        jenisHama: jenisHama.value,
        jumlah: jumlah.value,
        tanggal: formattedDate,
        dicatatOleh: currentUsername.value, // Menggunakan username yang sudah login
        fotoDokumentasi: imageFile.value!.path,
        kondisi: selectedCondition.value.toLowerCase(),
        catatan: catatan.value,
      );

      await _catchService.createCatch(catchData);

      Get.offNamed("/HistoryTool");
      Get.snackbar(
        'Sukses',
        'Data berhasil disimpan',
        snackPosition: SnackPosition.TOP,
      );
      resetForm();
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Error:')) {
        errorMessage = errorMessage.split('Error:')[1].trim();
      }
      Get.snackbar(
        'Error',
        'Gagal menyimpan data: $errorMessage',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetForm() {
    selectedCondition.value = '';
    jumlah.value = 0;
    jenisHama.value = '';
    catatan.value = '';
    imageFile.value = null;

    conditionError.value = '';
    jumlahError.value = '';
    jenisHamaError.value = '';
    catatanError.value = '';
    imageError.value = false;
  }
}