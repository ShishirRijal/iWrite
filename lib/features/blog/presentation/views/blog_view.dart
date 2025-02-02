import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/core/common/widgets/custom_loading_indicator.dart';
import 'package:iwrite/core/theme/app_pallete.dart';
import 'package:iwrite/core/utils/show_snackbar.dart';
import 'package:iwrite/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:iwrite/features/blog/presentation/views/add_blog_view.dart';
import 'package:iwrite/features/blog/presentation/widgets/custom_blog_card.dart';

class BlogView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogView());
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  void initState() {
    super.initState();

    context.read<BlogBloc>().add(BlogGetAll());
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showErrorSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return CustomLoadingIndicator();
          }

          if (state is BlogDisplaySuccess) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return CustomBlogCard(
                    blog,
                    color: index.isEven
                        ? AppPallete.gradient1
                        : AppPallete.gradient2,
                  );
                },
                itemCount: state.blogs.length,
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
