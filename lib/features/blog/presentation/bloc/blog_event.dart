part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final File image;
  final String title;
  final String content;
  final List<String> tags;
  final String userId;

  BlogUpload({
    required this.image,
    required this.title,
    required this.content,
    required this.tags,
    required this.userId,
  });
}
