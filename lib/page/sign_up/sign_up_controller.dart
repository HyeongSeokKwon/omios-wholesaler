import 'dart:io';

import 'package:deepy_wholesaler/http/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {
  String selectedBuilding = "";
  String selectedFloor = "";
  String selectedRoom = "";
  String businessName = "";
  String representativeName = "";
  String id = "";
  String pwd = "";

  String isIdDuplicated = "default";
  String isDuplicationCheck = "default";
  String isPwdValidate = "default";
  String isPwdSame = "default";
  String idErrorType = "";
  String passwordErrorType = "";

  HttpService httpservice = HttpService();
  Map<String, String> queryString = {};

  var businessRegistNumPhoto;
  XFile? pickedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> validateId(String id) async {
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
    if (regex.hasMatch(id) && id.length >= 4 && id.length <= 20) {
      queryString["wholesaler_name"] = id;
      var response = await httpservice
          .httpPublicGet("/user/unique/", queryString)
          .catchError((e) {
        throw Exception(e.toString());
      });

      switch (response['data']['is_unique']) {
        case true:
          isIdDuplicated = "accept";
          break;
        case false:
          isIdDuplicated = "deny";
          break;
        default:
      }
    } else if (id.length < 4 || id.length > 20) {
      isIdDuplicated = "deny";
    } else {
      isIdDuplicated = "default";
    }

    update();
    return;
  }

  void validatePassword(String password, String checkPassword) {
    RegExp regex = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[!-~]+$');
    validateDuplicationCheck(password, checkPassword);
    if (regex.hasMatch(password) && password.length >= 10) {
      isPwdValidate = "accept";
    } else if (password.isEmpty) {
      isPwdValidate = "default";
      passwordErrorType = "";
    } else {
      isPwdValidate = 'deny';
      passwordErrorType = "비밀번호는 대문자, 소문자, 숫자 포함 10글자 이내로 입력하세요";
    }

    update();
  }

  void validateDuplicationCheck(String password, String checkPassword) {
    if (password == checkPassword && password.isNotEmpty) {
      isPwdSame = "accept";
    } else if (checkPassword.isEmpty) {
      isPwdSame = "default";
    } else {
      isPwdSame = "deny";
    }

    update();
  }

  void clickedBuilding(String buildingName) {
    if (buildingName == selectedBuilding) {
      selectedBuilding = "";
    } else {
      selectedBuilding = buildingName;
    }
    update();
  }

  void clickedfloor(String floorName) {
    selectedFloor = floorName;
    update();
  }

  void clickedRoom(String roomName) {
    selectedRoom = roomName;
    update();
  }

  void getImageFromGallery() async {
    pickedFile = (await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    ));
    if (pickedFile != null) {
      businessRegistNumPhoto = Image.file(
        File(pickedFile!.path),
      );
    }
    update(['imageArea']);
  }

  void getImageFromCamera() async {
    pickedFile = (await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    ));
    if (pickedFile != null) {
      businessRegistNumPhoto = Image.file(
        File(pickedFile!.path),
      );
    }
    update(['imageArea']);
  }
}
