import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/core/usecases/usecase.dart';
import 'package:iwrite/features/blog/domain/entities/blog.dart';
import 'package:iwrite/features/blog/domain/usecases/get_blogs.dart';
import 'package:iwrite/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetBlogs _getBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetBlogs getBlogs,
  })  : _uploadBlog = uploadBlog,
        _getBlogs = getBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));

    on<BlogUpload>(_onBlogUpload);

    on<BlogGetAll>(_onBlogGetAll);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(UploadBlogParams(
      image: event.image,
      title: event.title,
      content: event.content,
      tags: event.tags,
      userId: event.userId,
    ));

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onBlogGetAll(BlogGetAll event, Emitter<BlogState> emit) async {
    final result = await _getBlogs(NoParams());

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogDisplaySuccess(blogs)),
    );
  }
}
