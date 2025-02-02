import 'package:flutter/material.dart';

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
