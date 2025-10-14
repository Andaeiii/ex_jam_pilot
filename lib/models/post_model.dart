import 'dart:convert';

import 'post_types_model.dart';
import 'postuser_model.dart';

class Post {
  final int id;
  final PostUser? user; // ✅ now it's an object, not just userId
  final PostType? postType;
  final String? content;
  final bool? hasImage;
  final String? imagePath;

  final bool? is_gallery;
  final bool? is_event;

  final dynamic galleryInfo;
  final dynamic eventInfo;

  final int numOfComments;

  final int? reactionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Post({
    required this.id,
    this.user,
    this.postType,
    this.content,
    this.hasImage,
    this.imagePath,

    this.is_gallery,
    this.is_event,
    this.galleryInfo,
    this.eventInfo,

    required this.numOfComments,

    this.reactionId,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user: json['user'] != null
          ? PostUser.fromJson(json['user'])
          : null, // ✅ maps user object
      postType: json['post_type'] != null
          ? PostType.fromJson(json['post_type'])
          : null,
      content: json['content'],
      hasImage: (json['has_image'] == 1 || json['has_image'] == true),
      imagePath: json['image_path'],
      reactionId: json['reaction_id'],

      is_gallery: (json['is_gallery'] == 1 || json['is_gallery'] == true),
      is_event: (json['is_event'] == 1 || json['is_event'] == true),

      // ✅ handle galleryInfo properly
      galleryInfo: json['galleryInfo'].toString(),

      eventInfo: json['eventInfo'] != null
          ? jsonDecode(json['eventInfo'])
          : null,

      numOfComments: json['numOfComments'],

      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(), // ✅ serialize back
      'post_type': postType?.toJson(),
      'content': content,
      'has_image': hasImage,
      'image_path': imagePath,

      'is_gallery': is_gallery,
      'is_event': is_event,
      'galleryInfo': galleryInfo,
      'eventInfo': eventInfo,

      'reaction_id': reactionId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
