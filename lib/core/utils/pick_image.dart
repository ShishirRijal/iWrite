import 'dart:io';
import 'package:image_picker/image_picker.dart';

/// Picks an image from the given source (camera or gallery)
Future<File?> pickImage({
  ImageSource source = ImageSource.gallery,
}) async {
  try {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
    return null;
  } catch (e) {
    print("Error picking image: $e");
  }
  return null;
}
