import 'package:deepy_wholesaler/http/http_service.dart';
import 'package:deepy_wholesaler/model/login_model.dart';
import 'package:deepy_wholesaler/page/deepy_home/home.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool? isAutoLoginChecked;
  late Map<String, dynamic> loginResponse;

  HttpService httpservice = HttpService();
  String errorString = "";
  String userId = "";
  String userPwd = "";
  late LoginRequestModel loginRequestModel;
  late final SharedPreferences prefs;

  Future<void> initLoginController(context) async {
    httpservice.getToken();
    prefs = await SharedPreferences.getInstance();
    isAutoLoginChecked = prefs.getBool('isChecked');

    if (isAutoLoginChecked == null) {
      isAutoLoginChecked = false;
      await prefs.setBool('isChecked', isAutoLoginChecked!);
    }

    if (httpservice.isRefreshExpired()) {
      // refresh token 만료되면 오토로그인 풀리게
      await prefs.setBool('isChecked', isAutoLoginChecked!);
    }
    autoLogin().catchError((e) {
      throw e;
    });

    update(["autoLogin"]);
  }

  void getLoginInfo(String id, String pwd) {
    userId = id;
    userPwd = pwd;
  }

  void checkedAutoLogin() {
    isAutoLoginChecked = !isAutoLoginChecked!;

    prefs.setBool('isChecked', isAutoLoginChecked!);
    update(["autoLogin"]);
  }

  Future<void> autoLogin() async {
    if (prefs.getBool("isChecked") == true) {
      try {
        httpservice.updateToken();
        Get.to(() => const Home());
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<bool> loginRequest() async {
    Map<String, dynamic> responseData;
    loginRequestModel = LoginRequestModel(userId, userPwd);

    try {
      loginResponse =
          await httpservice.httpPost('/token/', loginRequestModel.toJson());

      //만약 ID PW가 틀리면 =>
      if (loginResponse['message'] ==
          "No active account found with the given credentials") {
        return false;
      }
      //만약 ID PW가 맞으면=>
      else {
        responseData = loginResponse['data'];

        httpservice.setAccessToken(responseData['access']);
        httpservice.setRefreshToken(responseData['refresh']);
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginButtonPressed(String username, String password) {
    getLoginInfo(username, password);
    return loginRequest();
  }
}
