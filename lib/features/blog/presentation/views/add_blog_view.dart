import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:iwrite/core/common/widgets/custom_loading_indicator.dart';
import 'package:iwrite/core/constants/constants.dart';
import 'package:iwrite/core/utils/pick_image.dart';
import 'package:iwrite/core/utils/show_snackbar.dart';
import 'package:iwrite/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:iwrite/features/blog/presentation/views/blog_view.dart';
import 'package:iwrite/features/blog/presentation/widgets/blog_editor.dart';
import 'package:iwrite/features/blog/presentation/widgets/custom_tag_chip.dart';
import 'package:iwrite/features/blog/presentation/widgets/select_image_card.dart';

class AddBlogView extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlogView());
  const AddBlogView({super.key});

  @override
  State<AddBlogView> createState() => _AddBlogViewState();
}

class _AddBlogViewState extends State<AddBlogView> {
  final formKey = GlobalKey<FormState>();
  final List<String> selectedTags = [];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;

  // Select Image
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  // Toggle Tag Selection
  void toggleTagSelection(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  // Upload Blog
  void uploadBlog() {
    formKey.currentState!.validate();
    if (formKey.currentState!.validate() &&
        image != null &&
        selectedTags.isNotEmpty) {
      final userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(BlogUpload(
            image: image!,
            title: titleController.text.trim(),
            content: descriptionController.text.trim(),
            tags: selectedTags,
            userId: userId,
          ));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Blog'),
          actions: [
            IconButton(
              onPressed: uploadBlog,
              icon: const Icon(Icons.check),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
            if (state is BlogUploadSuccess) {
              Navigator.pushAndRemoveUntil(
                  context, BlogView.route(), (route) => false);
            }
            if (state is BlogFailure) {
              showErrorSnackbar(context, state.message);
            }
          }, builder: (context, state) {
            if (state is BlogLoading) {
              return CustomLoadingIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Upload Image
                    SelectImageCard(image: image, onTap: selectImage),

                    const SizedBox(height: 20),
                    // Tags
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CustomTagChip(
                            Constants.tags[index],
                            isSelected:
                                selectedTags.contains(Constants.tags[index]),
                            onTap: () {
                              setState(() {
                                toggleTagSelection(Constants.tags[index]);
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, _) {
                          return const SizedBox(width: 20);
                        },
                        itemCount: Constants.tags.length,
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Title
                    BlogEditor(
                        controller: titleController, hintText: 'Blog Title'),

                    // Description
                    const SizedBox(height: 20),
                    BlogEditor(
                        controller: descriptionController,
                        hintText: 'Blog Content'),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
