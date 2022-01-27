import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegistController extends GetxController {
  TextEditingController priceEditController = TextEditingController();
  void addPrice(int addPrice) {
    if (priceEditController.text.isEmpty) {
      priceEditController.text = "0";
    }
    priceEditController.text =
        (int.parse(priceEditController.text) + addPrice).toString();
    update();
  }
}
