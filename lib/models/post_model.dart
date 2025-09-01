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
