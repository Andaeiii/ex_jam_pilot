import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // Reactive list of images
  var selectedImages = <File>[].obs;

  Future<void> pickImages() async {
    final pickedFiles = await _picker.pickMultiImage(); // multiple select
    if (pickedFiles.isNotEmpty) {
      selectedImages.assignAll(pickedFiles.map((e) => File(e.path)).toList());
    }
  }

  void uploadImages() {
    if (selectedImages.isNotEmpty) {
      // 🔥 Implement API upload here
      Get.snackbar("Success", "${selectedImages.length} images uploaded!");
    } else {
      Get.snackbar("Error", "Please select images first.");
    }
  }
}
