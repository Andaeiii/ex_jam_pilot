import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import './apiconfig.dart';

class ApiClient {
  final Dio dio;
  final GetStorage storage = GetStorage();

  ApiClient({String? baseUrl})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl ?? "http://$ipaddr/exjam_api/public/api",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {"Accept": "application/json"},
        ),
      ) {
    // ✅ Add interceptor to inject token if it exists
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = storage.read("token");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          print("API Error: ${e.response?.data ?? e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  /// ✅ POST request
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    return await dio.post(endpoint, data: data);
  }

  /// ✅ GET request
  Future<Response> get(String endpoint) async {
    return await dio.get(endpoint);
  }

  /// ✅ PUT request
  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    return await dio.put(endpoint, data: data);
  }

  /// ✅ DELETE request
  Future<Response> delete(String endpoint) async {
    return await dio.delete(endpoint);
  }
}
