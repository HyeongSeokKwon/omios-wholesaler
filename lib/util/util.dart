import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Scale {
  static late double width;
  static late double height;

  static void setScale(BuildContext context) {
    width = MediaQuery.of(context).size.width / 414;
    height = MediaQuery.of(context).size.height / 896;
  }
}

String setNumberFormat(int price) {
  final oCcy = NumberFormat("#,###", "ko_KR");
  return oCcy.format(price);
}

TextStyle textStyle(
  Color color,
  FontWeight fontWeight,
  var fontFamily,
  var fontSize,
) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontStyle: FontStyle.normal,
    fontFamily: fontFamily,
    fontSize: fontSize * Scale.height,
  );
}
