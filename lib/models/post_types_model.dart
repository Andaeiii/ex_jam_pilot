class PostType {
  final int id;
  final String title;

  PostType({required this.id, required this.title});

  factory PostType.fromJson(Map<String, dynamic> json) {
    return PostType(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
