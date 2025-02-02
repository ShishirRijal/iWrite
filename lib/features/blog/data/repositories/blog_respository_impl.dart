import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:iwrite/core/error/failures.dart';
import 'package:iwrite/core/network/connection_checker.dart';
import 'package:iwrite/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:iwrite/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:iwrite/features/blog/data/models/blog_model.dart';
import 'package:iwrite/features/blog/domain/entities/blog.dart';
import 'package:iwrite/features/blog/domain/repositories/blog_repositories.dart';
import 'package:uuid/uuid.dart';

class BlogRespositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRespositoryImpl({
    required this.blogRemoteDataSource,
    required this.blogLocalDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required List<String> tags,
      required String userId}) async {
    if (!await connectionChecker.isConnected) {
      return Left(Failure('No internet connection found!'));
    }

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
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }

      final blogs = await blogRemoteDataSource.getBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return Right(blogs);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
