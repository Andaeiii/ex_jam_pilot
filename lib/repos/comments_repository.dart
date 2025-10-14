import 'package:dio/dio.dart';
import 'package:exjam_prj/models/comment_model.dart';
import '../apis/api_client.dart';

class CommentsRepository {
  final ApiClient apiClient = ApiClient();

  Future<List<Comment>> getCommentsByPost(int postId) async {
    try {
      final response = await apiClient.get("/$postId/comments");
      final List<Comment> comments = (response.data as List)
          .map((json) => Comment.fromJson(json))
          .toList();

      return comments;
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data["message"] ??
          e.response?.statusMessage ??
          "Failed to fetch posts";
      throw Exception(errorMessage);
    }
  }

  Future<String> addComment(Map<String, dynamic> commentData) async {
    try {
      final response = await apiClient.post("/comment", commentData);
      //return Comment.fromJson(response.data);
      return response.data['message'] ?? "Comment added successfully";
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data["message"] ??
          e.response?.statusMessage ??
          "Failed to add comment";
      throw Exception(errorMessage);
    }
  }

  Future<void> deletePost(int postId) async {
    await apiClient.delete('/posts/$postId');
  }
}
