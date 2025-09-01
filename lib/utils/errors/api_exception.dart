import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;

  // Factory method to parse Dio errors into readable messages
  factory ApiException.fromDioError(DioException error) {
    if (error.response != null) {
      final data = error.response?.data;

      // Try to extract common fields used by APIs (like Laravel, Node, etc.)
      if (data is Map<String, dynamic>) {
        if (data.containsKey("errors")) {
          // Validation errors (Laravel-style)
          final errors = (data["errors"] as Map).values
              .expand((v) => v)
              .join("\n");
          return ApiException(errors);
        }
        if (data.containsKey("message")) {
          return ApiException(data["message"]);
        }
        if (data.containsKey("error")) {
          return ApiException(data["error"]);
        }
      }

      return ApiException(data.toString());
    }

    // No server response (timeout, DNS, no internet, etc.)
    return ApiException("Network error: ${error.message}");
  }
}
