import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel {
  File imageFile;
  String base64;
  String imageName;

  ImageModel();

  ImageModel.name(this.imageFile, this.base64, this.imageName);
}

getImage(ImageSource imageSource, context) async {
  ImageModel imageModel;
  if (imageSource == ImageSource.gallery) {
    final picker = ImagePicker();
    var _pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
    );

    File image = await cropImage(_pickedFile.path);

    List<int> imageBytes = image.readAsBytesSync();

    String base64Image = base64Encode(imageBytes);

    String name = image.path.split('/').last;
    name = name.split('.').last;
    
    imageModel = new ImageModel.name(File(image.path), base64Image, name);
  } else {
    final picker = ImagePicker();
    var _pickedFile = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    File image = await cropImage(_pickedFile.path);

    List<int> imageBytes = image.readAsBytesSync();

    String base64Image = base64Encode(imageBytes);

    String name = image.path.split('/').last;
    name = name.split('.').last;
    
    imageModel = new ImageModel.name(File(image.path), base64Image, name);
  }
  return imageModel;
  
}

cropImage(filePath) async {
  File croppedImage = await ImageCropper.cropImage(
    iosUiSettings: IOSUiSettings(title: "Resmi Kırpın"),
    androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Resmi Kırpın",
        toolbarColor: Colors.black,
        hideBottomControls: true,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true),
    sourcePath: filePath,
  );

  return croppedImage;
}
