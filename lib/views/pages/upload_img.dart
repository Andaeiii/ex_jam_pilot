import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/UploadController.dart';

class UploadImgs extends StatelessWidget {
  final UploadController _controller = Get.put(UploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.image,
              color: Color.fromARGB(255, 71, 71, 71),
            ), // your icon
            SizedBox(width: 8),
            Text("Add Image(s)"),
          ],
        ),
        actions: [
          Directionality(
            textDirection: TextDirection.rtl, // right-to-left layout
            child: TextButton.icon(
              onPressed: _controller.pickImages,
              icon: Icon(Icons.add),
              label: Text("Add"),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        color: Colors.white,
        child: Column(
          children: [
            // Image Grid Preview
            Expanded(
              child: Obx(() {
                if (_controller.selectedImages.isEmpty) {
                  return Center(
                    child: Text(
                      "No images selected",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    final image = _controller.selectedImages[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 233, 232, 232), // #ccc
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // rounded corners
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // same as container
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.file(image, fit: BoxFit.cover),
                            ),

                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () =>
                                    _controller.selectedImages.removeAt(index),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: const Color.fromARGB(
                                    136,
                                    24,
                                    24,
                                    24,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            SizedBox(height: 20),

            Obx(() {
              if (_controller.isUploading.value) {
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: _controller.uploadProgress.value, // 0.0 → 1.0
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      minHeight: 6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${(_controller.uploadProgress.value * 100).toStringAsFixed(0)}%",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            }),

            SizedBox(height: 20),

            // Select Images Button
            ElevatedButton.icon(
              onPressed: _controller.pickImages,
              icon: Icon(Icons.photo_library),
              label: Text("Select Images"),
            ),

            SizedBox(height: 10),

            // Upload Button
            ElevatedButton.icon(
              onPressed: _controller.uploadImages,
              icon: Icon(Icons.cloud_upload),
              label: Text("Upload All"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
