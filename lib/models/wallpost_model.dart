class WallPost {
  final String id;
  final String wallType;
  final dynamic body;

  WallPost({required this.id, required this.wallType, this.body});

  factory WallPost.fromJson(Map<String, dynamic> json) {
    return WallPost(
      id: json['id'],
      wallType: json['wallType'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'wallType': wallType, 'body': body};
  }
}
