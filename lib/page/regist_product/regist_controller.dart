import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistController extends GetxController {
  TextEditingController priceEditController = TextEditingController();
  late TabController colorTabController;
  List<Map<String, dynamic>> selectedColor = [];

  List<dynamic> basicImages = [];
  int colorTabBarViewIndex = 0;

  XFile? pickedFile;
  Image? previewImage;
  final ImagePicker _picker = ImagePicker();

  void addPrice(int addPrice) {
    if (priceEditController.text.isEmpty) {
      priceEditController.text = "0";
    }
    priceEditController.text =
        (int.parse(priceEditController.text) + addPrice).toString();
    update();
  }

  bool isColorSelected(String color) {
    for (var i in selectedColor) {
      if (i['color'] == color) {
        return true;
      }
    }
    return false;
  }

  void clickColorButton(String color) {
    for (var i in selectedColor) {
      if (i['color'] == color) {
        selectedColor.remove(i);
        update();
        return;
      }
    }
    selectedColor.add({'color': color, 'image': null});

    update();
  }

  void clickColorTabBar(int index) {
    colorTabBarViewIndex = index;
    update(['color']);
  }

  void getImageFromGallery(String imageType) async {
    pickedFile = (await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    ));
    if (pickedFile != null) {
      switch (imageType) {
        case 'basic':
          basicImages.add(Image.file(
            File(pickedFile!.path),
          ));
          break;
        case 'color':
          selectedColor[colorTabBarViewIndex]['image'] =
              Image.file(File(pickedFile!.path));
          break;
        default:
      }
    }
    update(['imageArea']);
  }
}
