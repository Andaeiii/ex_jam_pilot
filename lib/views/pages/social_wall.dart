import 'package:exjam_prj/utils/helpers/AppConfig.dart';
import 'package:exjam_prj/views/comps/NetworkImgLdr.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/posts_controller.dart';
import '../../models/post_model.dart';
import '../../apis/config.dart';
import 'dart:convert';

import '../imgComps/SlideShowPg.dart';

class SocialWallPage extends StatefulWidget {
  @override
  State<SocialWallPage> createState() => _SocialWallPageState();
}

class _SocialWallPageState extends State<SocialWallPage> {
  late PostsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PostsController());
  }

  @override
  void dispose() {
    Get.delete<PostsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //var allposts = controller.posts;

      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text("Error: ${controller.errorMessage}"));
      }

      if (controller.posts.isEmpty) {
        return Center(child: Text("No posts available"));
      }

      return ListView.builder(
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          final post = controller.posts[index];
          return _buildPostCard(post);
        },
      );
    });
  }

  Widget _buildPostCard(Post post) {
    int commentsCount = post.numOfComments;

    String ucode = post.user?.usrcode ?? '';
    bool dp = post.user?.display_img ?? false;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header (avatar + name + time)
          ListTile(
            leading: GestureDetector(
              onTap: () {
                // Navigate to user profile
                Get.toNamed('/profile/${post.user!.id}');
              },
              child: AppConfig.getDisplayImg(ucode, hasDP: dp, size: 26),
            ),
            title: Text(
              post.user != null
                  ? "${post.user!.firstname} ${post.user!.lastname}"
                  : "Unknown User",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("2hr ago"),
            trailing: PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 'edit') {
                  // handle edit
                  print('Edit selected');
                } else if (value == 'delete') {
                  // handle delete
                  controller.deletePost(post.id);
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: const [
                      Icon(Icons.edit, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: const [
                      Icon(Icons.delete, color: Colors.redAccent),
                      SizedBox(width: 10),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Post content
          // if (post.postType?.title == "text")
          //_buildTextContent(post),
          _buildImageContent(post),
          if (post.postType?.title == "mixed") _buildMixedContent(post),
          if (post.galleryInfo != '') _buildGallery(post.galleryInfo),
          //     post.galleryInfo is List &&
          //     post.galleryInfo.length > 0)
          //   _buildMasonry(post),

          // Action buttons (like, comment, share)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.thumb_up_alt_outlined, "Like", () {}),
                _buildActionButton(
                  Icons.mode_comment_outlined,
                  "Comment ($commentsCount)",
                  () => Get.toNamed('/comments/${post.id}'),
                ),
                _buildActionButton(Icons.share_outlined, "Share", () {}),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildTextContent(Post post) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(post.galleryInfo ?? '', style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildImageContent(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.content?.isNotEmpty ?? false)
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(post.content ?? '', style: TextStyle(fontSize: 16)),
          ),
        if (post.imagePath != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: NetworkImgLdr(imageUrl: post.imagePath!, fit: BoxFit.cover),
          ),
      ],
    );
  }

  Widget _buildMixedContent(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(post.content ?? '', style: TextStyle(fontSize: 16)),
        ),
        if (post.imagePath != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: NetworkImgLdr(imageUrl: post.imagePath!, fit: BoxFit.cover),
            //Image.network(post.imagePath!, fit: BoxFit.cover),
          ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: Colors.grey[700]),
      label: Text(label, style: TextStyle(color: Colors.grey[700])),
    );
  }
}

/// Your gallery widget
Widget _buildGallery(String jsonString) {
  // Decode JSON into a list
  final List<dynamic> photos = jsonDecode(jsonString);
  final List<String> urls = photos
      .map<String>((photo) => '$serverURL${photo['fld']}') //as string
      .toList();

  return MasonryGridView.count(
    crossAxisCount: 2, // number of columns
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(), // use with scroll parent
    itemCount: urls.length,
    itemBuilder: (context, index) {
      final url = urls[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (_) => SlideshowGallery(photos: urls, initialIndex: index),
              builder: (_) {
                return SlideshowGallery(photos: urls, initialIndex: index);
              },
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 150,
                color: Colors.grey[200],
                child: Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 150,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, size: 50),
              );
            },
          ),
        ),
      );
    },
  );
}
