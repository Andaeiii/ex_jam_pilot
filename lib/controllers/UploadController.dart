import 'dart:io';
import 'package:exjam_prj/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../apis/api_client.dart';

class UploadController extends BaseController {
  final ImagePicker _picker = ImagePicker();
  final ApiClient apiClient = Get.put(ApiClient());

  var selectedImages = <File>[].obs;
  var isUploading = false.obs;
  var uploadProgress = 0.0.obs;

  Future<void> pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages.assignAll(pickedFiles.map((e) => File(e.path)).toList());
    }
  }

  Future<void> uploadImages(titletxt) async {
    if (selectedImages.isEmpty) {
      Get.snackbar("Error", "Please select images first.");
      return;
    }

    try {
      isUploading.value = true;
      uploadProgress.value = 0.0;

      //print(selectedImages);

      final response = await apiClient.uploadImages(
        titletxt,
        selectedImages,
        onSendProgress: (sent, total) {
          uploadProgress.value = sent / total;
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Images uploaded successfully!");
        //Get.back(); // Go back to the previous screen
        Get.offAllNamed('/home');
      } else {
        print('error' + response.statusMessage.toString());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isUploading.value = false;
    }
  }
}
