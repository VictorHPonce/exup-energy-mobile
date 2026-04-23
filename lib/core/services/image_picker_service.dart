import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickAndCropImage({
    required ImageSource source,
    required Color primaryColor,
  }) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (pickedFile == null) return null;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar Foto',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: 'Recortar Foto'),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }
}