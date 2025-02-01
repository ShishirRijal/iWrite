import 'package:flutter/material.dart';
import 'package:iwrite/features/blog/presentation/views/add_blog_view.dart';

class BlogView extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogView());
  const BlogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(AddBlogView.route());
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text('Blog'),
      ),
    );
  }
}
