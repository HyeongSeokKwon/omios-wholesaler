import 'package:get/get.dart';

class SignUpController extends GetxController {
  String selectedBuilding = "";
  String selectedFloor = "";
  String selectedRoom = "";
  String id = "";
  String pwd = "";
  String isDuplicationCheck = "default";
  String isPwdValidate = "default";
  String isPwdSame = "default";

  void validatePassword(String password, String checkPassword) {
    RegExp regex = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[!-~]+$');
    validateDuplicationCheck(password, checkPassword);
    if (regex.hasMatch(password) && password.length >= 10) {
      isPwdValidate = "accept";
    } else if (password.isEmpty) {
      isPwdValidate = "default";
    } else {
      isPwdValidate = 'deny';
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
}
