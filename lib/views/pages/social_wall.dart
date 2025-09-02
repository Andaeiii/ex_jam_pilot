import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/posts_controller.dart';
import '../../models/post_model.dart';

class SocialWallPage extends StatelessWidget {
  final PostsController controller = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Social Wall")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text("Error: ${controller.errorMessage}"));
        }

        if (controller.posts.isEmpty) {
          return const Center(child: Text("No posts available"));
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return _buildPostCard(post);
          },
        );
      }),
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header (avatar + name + time)
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.user.avatar),
            ),
            title: Text(
              post.user.firstname + " " + post.user.lastname,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("2hr ago"),
            trailing: Icon(Icons.more_horiz),
          ),

          // Post content
          if (post.type == "text") _buildTextContent(post),
          if (post.type == "image") _buildImageContent(post),
          if (post.type == "mixed") _buildMixedContent(post),

          // Action buttons (like, comment, share)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.thumb_up_alt_outlined, "Like", () {}),
                _buildActionButton(Icons.mode_comment_outlined, "Comment", () {
                  Get.toNamed('/comments', arguments: {"postId": post.id});
                  // print("Comment on post ${post.id}");
                }),
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
      padding: const EdgeInsets.all(12.0),
      child: Text(post.content, style: TextStyle(fontSize: 16)),
    );
  }

  Widget _buildImageContent(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.content.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(post.content, style: TextStyle(fontSize: 16)),
          ),
        if (post.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(post.imageUrl!, fit: BoxFit.cover),
          ),
      ],
    );
  }

  Widget _buildMixedContent(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(post.content, style: TextStyle(fontSize: 16)),
        ),
        if (post.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(post.imageUrl!, fit: BoxFit.cover),
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
