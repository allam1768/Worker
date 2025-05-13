import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatelessWidget {
  final Rx<File?> imageFile;
  final RxBool imageError;
  final String title;
  final bool showButton;
  final bool useBottomSheet;
  final ImageSource defaultSource;

  ImageUpload({
    required this.imageFile,
    required this.imageError,
    this.title = "Upload Image",
    this.showButton = true,
    this.useBottomSheet = true,
    this.defaultSource = ImageSource.camera,
  });

  Future<void> pickImage() async {
    final picker = ImagePicker();

    if (!useBottomSheet) {
      final pickedFile = await picker.pickImage(source: defaultSource);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
        imageError.value = false;
      }
      return;
    }

    await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(MediaQuery.of(Get.context!).size.width * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(MediaQuery.of(Get.context!).size.width * 0.05),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pilih Gambar",
              style: TextStyle(
                fontSize: MediaQuery.of(Get.context!).size.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPickButton(Icons.camera_alt, "Camera", () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    imageFile.value = File(pickedFile.path);
                    imageError.value = false;
                    Get.back();
                  }
                }),
                _buildPickButton(Icons.image, "Gallery", () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    imageFile.value = File(pickedFile.path);
                    imageError.value = false;
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
            radius: MediaQuery.of(Get.context!).size.width * 0.075,
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon,
                size: MediaQuery.of(Get.context!).size.width * 0.075,
                color: Colors.black54),
          ),
          SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.008),
          Text(label,
              style: TextStyle(
                  fontSize: MediaQuery.of(Get.context!).size.width * 0.035)),
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
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(Get.context!).size.width * 0.03),
                child: Image.file(
                  imageFile.value!,
                  width: MediaQuery.of(Get.context!).size.width * 0.75,
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
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                fontWeight: FontWeight.bold)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        GestureDetector(
          onTap: () => pickImage(),
          child: Obx(() => Container(
                height: MediaQuery.of(context).size.height * 0.19,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.03),
                  border: Border.all(
                    color: imageError.value ? Colors.red : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: imageFile.value != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.03),
                        child: Image.file(imageFile.value!, fit: BoxFit.cover),
                      )
                    : Icon(Icons.camera_alt, size: 50, color: Colors.grey),
              )),
        ),
        Obx(() => imageError.value
            ? Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                    left: MediaQuery.of(context).size.width * 0.01),
                child: Text(
                  "Image harus diisi!",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: Colors.red),
                ),
              )
            : SizedBox()),
      ],
    );
  }
}
