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
        "user": UserModel.fromJson(response.data["user"]),
        "token": response.data["token"],
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await apiClient.get("/profile");
      return UserModel.fromJson(response.data["user"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await apiClient.post("/logout", {});
    } catch (e) {
      rethrow;
    }
  }
}
