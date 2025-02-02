import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iwrite/core/theme/app_pallete.dart';

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
