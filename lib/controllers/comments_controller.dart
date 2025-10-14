import 'package:exjam_prj/controllers/base_controller.dart';
import 'package:exjam_prj/models/comment_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repos/comments_repository.dart';

class CommentController extends BaseController {
  var comments = <Comment>[].obs; // replace String wit Comment model
  final CommentsRepository _commentsRepo = CommentsRepository();
  final GetStorage storage = GetStorage();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchComments(int postId) async {
    try {
      isLoading(true);
      final fetchedComments = await _commentsRepo.getCommentsByPost(postId);
      comments.assignAll(fetchedComments);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> addComment(String text, int postId) async {
    if (text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Comment cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Map<String, dynamic> usrcomment = {
      "post_id": postId,
      "user_id": storage.read("userId"),
      "content": text.trim(),
    };

    try {
      isLoading(true);
      await _commentsRepo.addComment(usrcomment); // post new comment...
      await fetchComments(postId); // refresh if success..
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}


//