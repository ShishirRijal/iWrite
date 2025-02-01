import 'package:flutter/material.dart';
import 'package:iwrite/core/theme/app_pallete.dart';

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,
        style: TextStyle(
          color: AppPallete.whiteColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        )),
    duration: Duration(seconds: 2),
    backgroundColor: AppPallete.errorColor,
  ));
}

void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,
        style: TextStyle(
          color: AppPallete.whiteColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        )),
    duration: Duration(seconds: 2),
    backgroundColor: AppPallete.successColor,
  ));
}
