part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {
  BlogSuccess();
}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure(this.message);
}
