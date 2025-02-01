import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/failures.dart';
import 'package:iwrite/features/blog/domain/entities/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> tags,
    required String userId,
  });
}
