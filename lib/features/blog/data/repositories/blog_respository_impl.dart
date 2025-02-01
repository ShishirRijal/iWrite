import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/failures.dart';
import 'package:iwrite/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:iwrite/features/blog/data/models/blog_model.dart';
import 'package:iwrite/features/blog/domain/entities/blog.dart';
import 'package:iwrite/features/blog/domain/repositories/blog_repositories.dart';
import 'package:uuid/uuid.dart';

class BlogRespositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRespositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required List<String> tags,
      required String userId}) async {
    BlogModel blog = BlogModel(
      id: const Uuid().v1(),
      userId: userId,
      title: title,
      content: content,
      imageUrl: '',
      tags: tags,
      updatedAt: DateTime.now(),
    );

    try {
      final imageUrl = await blogRemoteDataSource.uploadImage(
        image: image,
        blog: blog,
      );
      // update imageUrl
      blog = blog.copyWith(imageUrl: imageUrl);

      // update image
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blog);

      return Right(uploadedBlog);
    } catch (e) {
      print("Error uploading blog: $e");
      return Left(Failure(e.toString()));
    }
  }
}
