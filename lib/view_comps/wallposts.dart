import 'package:flutter/material.dart';

class Post {
  final String userName;
  final String userAvatar;
  final String timeAgo;
  final String type; // "text", "image", "mixed"
  final String content;
  final String? imageUrl;

  Post({
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    required this.type,
    required this.content,
    this.imageUrl,
  });
}

class WallPage extends StatelessWidget {
  // Fake posts
  final List<Post> posts = [
    Post(
      userName: "John Doe",
      userAvatar: "https://i.pravatar.cc/150?img=3",
      timeAgo: "2h",
      type: "text",
      content: "Just finished a great Flutter project 🚀!",
    ),
    Post(
      userName: "Jane Smith",
      userAvatar: "https://i.pravatar.cc/150?img=5",
      timeAgo: "3h",
      type: "image",
      content: "Beautiful sunset I captured today 🌇",
      imageUrl: "https://picsum.photos/400/250",
    ),
    Post(
      userName: "Michael Lee",
      userAvatar: "https://i.pravatar.cc/150?img=8",
      timeAgo: "5h",
      type: "mixed",
      content: "Check out my new car! 🏎️",
      imageUrl: "https://picsum.photos/500/300",
    ),
    Post(
      userName: "Alice Green",
      userAvatar: "https://i.pravatar.cc/150?img=9",
      timeAgo: "1d",
      type: "text",
      content: "Life is beautiful when you code Flutter 💙",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return _buildPostCard(post);
      },
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header (avatar + name + time)
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.userAvatar),
            ),
            title: Text(
              post.userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post.timeAgo),
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
                _buildActionButton(Icons.thumb_up_alt_outlined, "Like"),
                _buildActionButton(Icons.mode_comment_outlined, "Comment"),
                _buildActionButton(Icons.share_outlined, "Share"),
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

  Widget _buildActionButton(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20, color: Colors.grey[700]),
      label: Text(label, style: TextStyle(color: Colors.grey[700])),
    );
  }
}
