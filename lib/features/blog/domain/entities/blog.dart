class Blog {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> tags;
  final DateTime updatedAt;
  final String? userName;

  Blog({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.tags,
    required this.updatedAt,
    this.userName,
  });
}
