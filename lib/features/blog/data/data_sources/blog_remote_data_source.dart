import 'dart:io';

import 'package:iwrite/core/error/exceptions.dart';
import 'package:iwrite/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage({
    required File image,
    required BlogModel blog,
  });
}

class BlogRemoteDataSourceImpl extends BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(response.first);
    } catch (e) {
      print("Error uploading blog: $e");
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload('blogs/${blog.id}', image);

      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl('blogs/${blog.id}');
    } catch (e) {
      print("Error uploading image: $e");
      throw ServerException(message: e.toString());
    }
  }
}
