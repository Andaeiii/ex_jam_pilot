// lib/utils/api_error.dart
import 'package:dio/dio.dart';

class ApiError implements Exception {
  final String message;

  ApiError(this.message);

  factory ApiError.fromDio(DioException e) {
    if (e.response != null) {
      return ApiError(e.response?.data["error"] ?? "Unknown server error");
    }
    return ApiError(e.message ?? "Network error");
  }

  @override
  String toString() => message;
}
