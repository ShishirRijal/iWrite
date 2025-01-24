import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    super.key,
  });
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  // final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isPassword,
      validator: (value) {
        // check for empty field
        if (value!.isEmpty) {
          return '$hintText is missing!';
        }
        return null;
      },
    );
  }
}
