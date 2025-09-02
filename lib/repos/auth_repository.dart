import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../apis/api_client.dart';

class AuthRepository {
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await apiClient.post("/login", {
        "email": email,
        "password": password,
      });

      return {
        "user": User.fromJson(response.data["user"]),
        "token": response.data["token"],
      };
    } on DioException catch (e) {
      // Extract error message from server response if available
      final errorMessage =
          e.response?.data["message"] ??
          e.response?.statusMessage ??
          "Login failed";
      throw Exception(errorMessage);
    }
  }

  Future<User> getProfile() async {
    try {
      final response = await apiClient.get("/profile");
      return User.fromJson(response.data["user"]);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data["message"] ??
          e.response?.statusMessage ??
          "Failed to fetch profile";
      throw Exception(errorMessage);
    }
  }

  Future<void> logout() async {
    try {
      await apiClient.post("/logout", {});
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data["message"] ??
          e.response?.statusMessage ??
          "Logout failed";
      throw Exception(errorMessage);
    }
  }
}
