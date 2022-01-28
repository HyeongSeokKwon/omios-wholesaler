import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistController extends GetxController {
  TextEditingController priceEditController = TextEditingController();
  List<String> selectedColor = [];
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

  void clickColorButton(String color) {
    if (selectedColor.contains(color)) {
      selectedColor.remove(color);
    } else {
      selectedColor.add(color);
    }
    update();
  }

  void getImageFromGallery() async {
    // ignore: invalid_use_of_visible_for_testing_member
    pickedFile = (await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    ));
    if (pickedFile != null) {
      previewImage = Image.file(
        File(pickedFile!.path),
      );
    }
    update();
  }
}
