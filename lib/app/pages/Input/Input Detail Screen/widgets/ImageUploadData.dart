import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageUploadData extends StatelessWidget {
  final Rx<File?> imageFile;
  final RxBool? imageError; // opsional sekarang
  final String title;
  final bool showButton;
  final String? imageUrl;
  final bool directCamera; // parameter baru untuk langsung buka camera

  ImageUploadData({
    required this.imageFile,
    this.imageError, // nggak wajib
    this.title = "Upload Image",
    this.showButton = true,
    this.imageUrl,
    this.directCamera = false, // default false untuk backward compatibility
  });

  Future<void> pickImageDirect() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70, // kompres biar gak terlalu besar
      maxWidth: 1200,
      maxHeight: 1200,
    );

    if (pickedFile != null) {
      try {
        // simpan di folder temporary app biar path-nya stabil
        final tempDir = await getTemporaryDirectory();
        final savedImage = await File(pickedFile.path).copy(
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg',
        );

        imageFile.value = savedImage;
        imageError?.value = false;
      } catch (e) {
        imageError?.value = true;
        Get.snackbar(
          'Error',
          'Gagal menyimpan gambar: $e',
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }


  Future<void> pickImage() async {
    final picker = ImagePicker();

    await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pilih Gambar",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPickButton(Icons.camera_alt, "Camera", () async {
                  final pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    imageFile.value = File(pickedFile.path);
                    imageError?.value = false;
                    Get.back();
                  }
                }),
                _buildPickButton(Icons.image, "Gallery", () async {
                  final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    imageFile.value = File(pickedFile.path);
                    imageError?.value = false;
                    Get.back();
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, size: 30.sp, color: Colors.black54),
          ),
          SizedBox(height: 5.h),
          Text(label, style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }

  void showPreview() {
    if (imageFile.value == null) return;

    Get.dialog(
      GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          color: Colors.black.withOpacity(0.8),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 1,
              maxScale: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  imageFile.value!,
                  width: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
      barrierColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () => pickImageDirect(), // menggunakan fungsi baru
          child: Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: imageError?.value == true
                    ? Colors.red
                    : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: Obx(() => imageFile.value != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.file(imageFile.value!, fit: BoxFit.cover),
            )
                : imageUrl != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                imageUrl!.trim().replaceAll(' ', ''),
                fit: BoxFit.cover,
                headers: {
                  'Accept': 'image/*',
                  'ngrok-skip-browser-warning': '1',
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes !=
                          null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(height: 8),
                      Text(
                        'Gambar tidak tersedia',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Coba refresh halaman',
                        style: TextStyle(
                            color: Colors.red, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
                : Icon(Icons.camera_alt, size: 50, color: Colors.grey)),
          ),
        ),
        if (imageError != null)
          Obx(() => imageError!.value
              ? Padding(
            padding: EdgeInsets.only(top: 4.h, left: 4.w),
            child: Text(
              'Gambar harus diisi',
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          )
              : SizedBox()),
      ],
    );
  }
}