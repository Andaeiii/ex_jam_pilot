import 'package:dio/dio.dart';
import 'package:exjam_prj/models/Profile_model.dart';
import '../apis/api_client.dart';

class ProfileRepository {
  final ApiClient apiClient = ApiClient();

  Future<Profile> getUserProfile(int userId) async {
    try {
      final response = await apiClient.get("/$userId/profile");
      var result = response.data['data'];
      return Profile.fromJson(result);
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data["message"] ??
          e.response?.statusMessage ??
          "Failed to fetch posts";
      throw Exception(errorMessage);
    }
  }

  Future<String> updateProfile(Map<String, dynamic> ProfileData) async {
    try {
      final response = await apiClient.post("/Profile", ProfileData);
      //return Profile.fromJson(response.data);
      return response.data['message'] ?? "Profile added successfully";
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data["message"] ??
          e.response?.statusMessage ??
          "Failed to add Profile";
      throw Exception(errorMessage);
    }
  }

  Future<void> deletePost(int postId) async {
    await apiClient.delete('/posts/$postId');
  }
}
