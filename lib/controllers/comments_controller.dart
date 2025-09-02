import 'package:get/get.dart';

class CommentController extends GetxController {
  var comments = <String>[].obs;

  void addComment(String text) {
    if (text.trim().isNotEmpty) {
      comments.insert(0, text.trim()); // add newest at top
    }
  }
}
