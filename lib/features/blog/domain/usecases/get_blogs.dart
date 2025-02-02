import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/failures.dart';
import 'package:iwrite/core/usecases/usecase.dart';
import 'package:iwrite/features/blog/domain/entities/blog.dart';
import 'package:iwrite/features/blog/domain/repositories/blog_repositories.dart';

class GetBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository repository;

  GetBlogs(this.repository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams _) async {
    return await repository.getBlogs();
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
