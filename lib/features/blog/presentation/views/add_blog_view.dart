import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwrite/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:iwrite/core/common/widgets/custom_loading_indicator.dart';
import 'package:iwrite/core/theme/app_pallete.dart';
import 'package:iwrite/core/utils/pick_image.dart';
import 'package:iwrite/core/utils/show_snackbar.dart';
import 'package:iwrite/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:iwrite/features/blog/presentation/views/blog_view.dart';

class AddBlogView extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlogView());
  const AddBlogView({super.key});

  @override
  State<AddBlogView> createState() => _AddBlogViewState();
}

class _AddBlogViewState extends State<AddBlogView> {
  final formKey = GlobalKey<FormState>();
  final tags = ['Business', 'Technology', 'Programming', 'Health', 'Science'];
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
            if (state is BlogSuccess) {
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
                              tags[index],
                              isSelected: selectedTags.contains(tags[index]),
                              onTap: () {
                                setState(() {
                                  toggleTagSelection(tags[index]);
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, _) {
                            return const SizedBox(width: 20);
                          },
                          itemCount: tags.length),
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

class BlogEditor extends StatelessWidget {
  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      validator: (value) {
        // If a validator is provided, use it
        if (validator != null) {
          return validator!(value);
        }

        // Else, use the default validator
        // check for empty field
        if (value!.isEmpty) {
          return '$hintText is missing!';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class CustomTagChip extends StatelessWidget {
  const CustomTagChip(
    this.title, {
    super.key,
    this.isSelected = false,
    this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? null
                : Border.all(color: AppPallete.borderColor, width: 2)),
        child: Chip(
            color: WidgetStatePropertyAll(
                isSelected ? AppPallete.gradient1 : AppPallete.backgroundColor),
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )),
      ),
    );
  }
}

class SelectImageCard extends StatelessWidget {
  const SelectImageCard({
    super.key,
    this.image,
    this.onTap,
  });
  final VoidCallback? onTap;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        radius: const Radius.circular(10),
        color: AppPallete.borderColor,
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        strokeWidth: image == null ? 2 : 0,
        dashPattern: [10, 4],
        child: SizedBox(
          // dotted border
          height: 150, width: double.infinity,
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(image!, fit: BoxFit.cover))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 50),
                    const SizedBox(height: 20),
                    Text('Select your image', style: TextStyle(fontSize: 20)),
                  ],
                ),
        ),
      ),
    );
  }
}
