// lib/repository/auth_repository.dart
import 'package:dio/dio.dart';
import '../apis/api_client.dart';
import '../models/user_model.dart';
import '../utils/api_error.dart';

class AuthRepository {
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await apiClient.dio.post( 
        "/login",
        data: {"email": email, "password": password}
      );

      return {
        "user": UserModel.fromJson(response.data["user"]),
        "token": response.data["token"],
      };
    } on DioException catch (e) {
      throw ApiError.fromDio(e); // Custom error handler
    }
  }
}
