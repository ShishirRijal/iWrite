// Custom Button
import 'package:flutter/material.dart';
import 'package:iwrite/core/theme/app_pallete.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(350, 50)),
            backgroundColor:
                WidgetStatePropertyAll(AppPallete.transparentColor),
            shadowColor: WidgetStatePropertyAll(AppPallete.transparentColor),
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
