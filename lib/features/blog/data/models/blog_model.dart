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
}
