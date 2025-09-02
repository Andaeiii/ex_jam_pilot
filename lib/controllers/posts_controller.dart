import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../repos/posts_repository.dart';
import '../models/post_model.dart';

class PostsController extends GetxController {
  final PostsRepository _postsRepository = PostsRepository();
  final GetStorage storage = GetStorage();

  var isLoading = false.obs;
  var errorMessage = "".obs;

  // 👇 store posts in an observable list
  var posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      final fetchedPosts = await _postsRepository.getAllPosts();
      posts.assignAll(fetchedPosts); // 👈 update observable list
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading(false);
    }
  }
}
