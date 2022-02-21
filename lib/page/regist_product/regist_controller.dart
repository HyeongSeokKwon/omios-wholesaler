import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistController extends GetxController {
  static const String s = "S";
  static const String m = "M";
  static const String l = "L";
  static const String xl = "XL";

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
  List<dynamic> pricePerOption = [];

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

  void changingPricePerOption(String type, int index) {
    if (type == "plus") {
      pricePerOption[index]['price_difference'] += 500;
    } else {
      pricePerOption[index]['price_difference'] -= 500;
    }
    update();
  }

  void clickColorButton(String color) {
    for (var i in selectedColor) {
      if (i['color'] == color) {
        if (pricePerOptionClicked) {
          pricePerOption.removeWhere((element) => element['color'] == color);
        }

        selectedColor.remove(i);
        if (selectedColor.isEmpty) {
          pricePerOption = [];
          pricePerOptionClicked = false;
        }
        update();
        return;
      }
    }
    selectedColor.add({'color': color, 'image': null});
    if (pricePerOptionClicked) {
      for (var size in selectedSize) {
        pricePerOption
            .add({'color': color, 'size': size, 'price_difference': 0});
      }
    }
    update();
  }

  void clickSizeButton(String size) {
    if (isSizedSelected(size)) {
      // 사이즈 취소 이벤트시
      if (pricePerOptionClicked) {
        // 옵션별 가격 체크 되어있으면
        pricePerOption.removeWhere((element) => element['size'] == size);
      }
      selectedSize.remove(size);
      if (selectedSize.isEmpty) {
        //선택된 사이즈리스트 비어있으면
        pricePerOption = [];
        pricePerOptionClicked = false;
      }
      update();
      return;
    }

    //사이즈 추가 이벤트시
    switch (size) {

      // 옵션별 가격 체크 상황에 무관하게 수행되어야할 로직
      case "S-M":
        if (!isSizedSelected(s) || !isSizedSelected(m)) {
          if (!isSizedSelected(s)) {
            selectedSize.add(s);
          }
          if (!isSizedSelected(m)) {
            selectedSize.add(m);
          }
        } else {
          selectedSize.remove(s);
          selectedSize.remove(m);
        }
        break;
      case "S-L":
        if (!isSizedSelected(s) || !isSizedSelected(m) || !isSizedSelected(l)) {
          if (!isSizedSelected(s)) {
            selectedSize.add(s);
          }
          if (!isSizedSelected(m)) {
            selectedSize.add(m);
          }
          if (!isSizedSelected(l)) {
            selectedSize.add(l);
          }
        } else {
          selectedSize.remove(s);
          selectedSize.remove(m);
          selectedSize.remove(l);
        }
        break;

      case "S-XL":
        if (!isSizedSelected(s) ||
            !isSizedSelected(m) ||
            !isSizedSelected(l) ||
            !isSizedSelected(xl)) {
          if (!isSizedSelected(s)) {
            selectedSize.add(s);
          }
          if (!isSizedSelected(m)) {
            selectedSize.add(m);
          }
          if (!isSizedSelected(l)) {
            selectedSize.add(l);
          }
          if (!isSizedSelected(xl)) {
            selectedSize.add(xl);
          }
        } else {
          selectedSize.remove(s);
          selectedSize.remove(m);
          selectedSize.remove(l);
          selectedSize.remove(xl);
        }
        break;
      default:
        selectedSize.add(size);
    }
    if (selectedSize.isEmpty) {
      //선택된 사이즈리스트 비어있으면
      pricePerOption = [];
      pricePerOptionClicked = false;
      update();
      return;
    }
    if (pricePerOptionClicked) {
      pricePerOption.clear();
      for (var color in selectedColor) {
        for (var size in selectedSize) {
          pricePerOption.add(
            {'color': color['color'], 'size': size, 'price_difference': 0},
          );
        }
      }
    }

    update();
    return;
  }

  void clickPricePerOption() {
    pricePerOption.clear();
    pricePerOptionClicked = !pricePerOptionClicked;

    for (var color in selectedColor) {
      for (var size in selectedSize) {
        pricePerOption.add(
          {'color': color['color'], 'size': size, 'price_difference': 0},
        );
      }
    }

    update();
  }

  void removeSize(index) {
    if (pricePerOptionClicked) {
      pricePerOption
          .removeWhere((element) => element['size'] == selectedSize[index]);
    }
    selectedSize.removeAt(index);
    if (selectedSize.isEmpty) {
      pricePerOption = [];
      pricePerOptionClicked = false;
    }

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
