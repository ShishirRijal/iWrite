import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    super.key,
  });
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        errorStyle: TextStyle(color: Colors.red, fontSize: 14),
      ),
      obscureText: isPassword,
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
    );
  }
}
