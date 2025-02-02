import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/failures.dart';
import 'package:iwrite/core/usecases/usecase.dart';
import 'package:iwrite/features/blog/domain/entities/blog.dart';
import 'package:iwrite/features/blog/domain/repositories/blog_repositories.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository repository;

  UploadBlog(this.repository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await repository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      tags: params.tags,
      userId: params.userId,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String content;
  final List<String> tags;
  final String userId;

  UploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.tags,
    required this.userId,
  });
}
