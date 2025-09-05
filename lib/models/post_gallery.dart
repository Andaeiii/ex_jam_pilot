class PostPhoto {
  final int id;
  final String url;

  PostPhoto({required this.id, required this.url});

  factory PostPhoto.fromJson(Map<String, dynamic> json) {
    return PostPhoto(id: json['id'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url};
  }
}
