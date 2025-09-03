import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/ldx_controller.dart';
import 'config.dart';

class ApiClient {
  final dio.Dio dioClient;
  final GetStorage storage = GetStorage();

  ApiClient({String? baseUrl})
    : dioClient = dio.Dio(
        dio.BaseOptions(
          baseUrl: baseUrl ?? "http://$ipaddr/exjam_api/public/api",
          connectTimeout: Duration(seconds: 30), // connection timeout
          receiveTimeout: Duration(seconds: 60), // response time
          sendTimeout: Duration(seconds: 60), // for uploads
          headers: {"Accept": "application/json"},
        ),
      ) {
    // ✅ Add interceptor to inject token if it exists
    dioClient.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          Get.find<LdxController>().show(); /////////////////// show loader.
          final token = storage.read("token");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },

        onResponse: (response, handler) {
          Get.find<LdxController>().hide(); ///////////////////hide loader.
          return handler.next(response);
        },

        onError: (dio.DioException e, handler) {
          Get.find<LdxController>().hide(); /////////////////// hide loader.
          //print("API Error: ${e.response?.data ?? e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  /// ✅ POST request
  Future<dio.Response> post(String endpoint, Map<String, dynamic> data) async {
    return await dioClient.post(endpoint, data: data);
  }

  /// ✅ GET request
  Future<dio.Response> get(String endpoint) async {
    return await dioClient.get(endpoint);
  }

  /// ✅ PUT request
  Future<dio.Response> put(String endpoint, Map<String, dynamic> data) async {
    return await dioClient.put(endpoint, data: data);
  }

  /// ✅ DELETE request
  Future<dio.Response> delete(String endpoint) async {
    return await dioClient.delete(endpoint);
  }

  Future<dio.Response> uploadImages(
    List<File> images, {
    void Function(int sent, int total)? onSendProgress,
  }) async {
    final formData = dio.FormData.fromMap({
      "images[]": [
        for (var i = 0; i < images.length; i++)
          await dio.MultipartFile.fromFile(
            images[i].path,
            filename: "image_$i.jpg",
          ),
      ],
      "userId": 1, //storage.read("user_id").toString() ,
    });

    return await dioClient.post(
      "/upload",
      data: formData,
      onSendProgress: onSendProgress,
    );
  }
}
