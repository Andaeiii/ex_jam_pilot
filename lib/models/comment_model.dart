import 'dart:convert';

class Comment {
  final int id;
  final int postId;
  final String? content;

  final String fullname;

  final String? squadron;
  final String? oldSquadron;

  final dynamic reactions; // can be Map or JSON string
  final String? time;
  final int userid;

  Comment({
    required this.id,
    required this.postId,
    required this.content,
    required this.fullname,
    this.squadron,
    this.oldSquadron,
    this.reactions,
    this.time,
    required this.userid,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['post_id'],
      content: json['content'],
      fullname: json['fullname'],
      squadron: json['squadron'],
      oldSquadron: json['old_squadron'],
      reactions: json['reactions'] is String
          ? jsonDecode(json['reactions'])
          : json['reactions'],
      time: json['time'],
      userid: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'content': content,
      'fullname': fullname,
      'squadron': squadron,
      'old_squadron': oldSquadron,
      'reactions': reactions is String ? reactions : jsonEncode(reactions),
      'time': time,
      'user_id': userid,
    };
  }
}



  /**
   * 
   
     "id": 1,
        "user_id": 1,
        "post_id": 1,
        "content": "You have this effortless glow that makes ordinary days feel special.",
        "reactions": "{\"like\":12,\"love\":7}",
        "created_at": "2025-10-12 07:53:04",
        "updated_at": "2025-10-12 07:53:04",
        "firstname": "Ande",
        "lastname": "Caleb",
        "middlename": null,
        "squadron": "crimson",
        "old_squadron": "red"


   */