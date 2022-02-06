import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistController extends GetxController {
  TextEditingController priceEditController = TextEditingController();
  late TabController colorTabController;

  List<Map<String, dynamic>> selectedColor = [];
  List<String> selectedSize = [];
  List<Map<String, dynamic>> selectedMaterialList = [];
  List<dynamic> basicImages = [];
  Map<String, String> selectedPropertyInfo = {};
  List<String> selectedWashingInfo = [];
  List<String> selectedStyleInfo = [];
  bool pricePerOptionClicked = false;

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

  bool isSizedSelected(String size) {
    if (selectedSize.contains(size)) {
      return true;
    }
    return false;
  }

  bool isMaterialSelected(String material) {
    for (var i in selectedMaterialList) {
      if (i['name'] == material) {
        return true;
      }
    }
    return false;
  }

  bool isPropertySelected(String type, String info) {
    if (selectedPropertyInfo[type] == info) {
      return true;
    }
    return false;
  }

  bool isWashingInfoSelected(String info) {
    if (selectedWashingInfo.contains(info)) {
      return true;
    }
    return false;
  }

  bool isStyleInfoSelected(String style) {
    if (selectedStyleInfo.contains(style)) {
      return true;
    }
    return false;
  }

  void isPricePerOptionClicked() {
    pricePerOptionClicked = !pricePerOptionClicked;
    update();
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

  void clickSizeButton(String size) {
    if (isSizedSelected(size)) {
      selectedSize.remove(size);
      update();
      return;
    }
    switch (size) {
      case "S-M":
        if (!isSizedSelected("S") || !isSizedSelected("M")) {
          if (!isSizedSelected("S")) {
            selectedSize.add("S");
          }
          if (!isSizedSelected("M")) {
            selectedSize.add("M");
          }
        } else {
          selectedSize.remove("S");
          selectedSize.remove("M");
        }
        update();
        return;
      case "S-L":
        if (!isSizedSelected("S") ||
            !isSizedSelected("M") ||
            !isSizedSelected("L")) {
          if (!isSizedSelected("S")) {
            selectedSize.add("S");
          }
          if (!isSizedSelected("M")) {
            selectedSize.add("M");
          }
          if (!isSizedSelected("L")) {
            selectedSize.add("L");
          }
        } else {
          selectedSize.remove("S");
          selectedSize.remove("M");
          selectedSize.remove("L");
        }

        update();
        return;
      case "S-XL":
        if (!isSizedSelected("S") ||
            !isSizedSelected("M") ||
            !isSizedSelected("L") ||
            !isSizedSelected("XL")) {
          if (!isSizedSelected("S")) {
            selectedSize.add("S");
          }
          if (!isSizedSelected("M")) {
            selectedSize.add("M");
          }
          if (!isSizedSelected("L")) {
            selectedSize.add("L");
          }
          if (!isSizedSelected("XL")) {
            selectedSize.add("XL");
          }
        } else {
          selectedSize.remove("S");
          selectedSize.remove("M");
          selectedSize.remove("L");
          selectedSize.remove("XL");
        }
        update();
        return;
      default:
    }
    selectedSize.add(size);
    update();
    return;
  }

  void removeSize(index) {
    selectedSize.removeAt(index);
    update();
  }

  void clickColorTabBar(int index) {
    colorTabBarViewIndex = index;
    update(['color']);
  }

  void clickMaterialButton(String material) {
    if (!isMaterialSelected(material)) {
      selectedMaterialList.add({'name': material, 'percent': null});
      update();
      return;
    } else {
      selectedMaterialList
          .removeWhere((element) => element['name'] == material);
      update();
      return;
    }
  }

  void clickPropertyInfo(String type, dynamic info) {
    selectedPropertyInfo[type] = info;

    update();
    return;
  }

  void clickWashingInfo(String info) {
    if (isWashingInfoSelected(info)) {
      selectedWashingInfo.remove(info);
      update();
      return;
    }
    selectedWashingInfo.add(info);
    update();
    return;
  }

  void clickStyle(String style) {
    if (isStyleInfoSelected(style)) {
      selectedStyleInfo.remove(style);
      update();
      return;
    }
    selectedStyleInfo.add(style);
    update();
    return;
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
