import 'package:iwrite/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.tags,
    required super.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      tags: List<String>.from(json['tags']),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'user_id': super.userId,
      'title': super.title,
      'content': super.content,
      'image_url': super.imageUrl,
      'tags': super.tags,
      'updated_at': super.updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? tags,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? super.id,
      userId: userId ?? super.userId,
      title: title ?? super.title,
      content: content ?? super.content,
      imageUrl: imageUrl ?? super.imageUrl,
      tags: tags ?? super.tags,
      updatedAt: updatedAt ?? super.updatedAt,
    );
  }
}
