import 'package:dio/dio.dart';
import '../utils/settings.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "$baseURL/public/api", // replace with your API base URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Dio get dio => _dio;
}
