import 'package:exjam_prj/views/layouts/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/posts_controller.dart';
import 'social_wall.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PostsController postsController;

  @override
  void initState() {
    super.initState();
    postsController = Get.put(PostsController()); // Create controller instance
  }

  @override
  void dispose() {
    // 👇 Properly dispose and remove the controller from GetX memory
    Get.delete<PostsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SideBarLayout(
      title: "HomePage",
      body: RefreshIndicator(
        onRefresh: () async {
          await postsController.refreshPosts();
        },
        
        child: SocialWallPage(),
      ),
    );
  }
}
