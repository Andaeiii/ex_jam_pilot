import 'package:dio/dio.dart';
import '../models/post_model.dart';
import '../apis/api_client.dart';

class PostsRepository {
  final ApiClient apiClient = ApiClient();

  Future<List<Post>> getAllPosts() async {
    try {
      final response = await apiClient.get("/posts");

      print('pr +' + response.toString());

      final List<Post> posts = (response.data['data'] as List)
          .map((json) => Post.fromJson(json))
          .toList();

      return posts;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data["message"] ??
          e.response?.statusMessage ??
          "Failed to fetch posts";
      throw Exception(errorMessage);
    }
  }
}
