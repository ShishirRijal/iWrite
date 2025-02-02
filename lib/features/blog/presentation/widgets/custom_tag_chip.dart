import 'package:flutter/material.dart';
import 'package:iwrite/core/theme/app_pallete.dart';

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
