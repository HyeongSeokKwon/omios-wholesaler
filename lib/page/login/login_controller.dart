import 'package:deepy_wholesaler/http/http_service.dart';
import 'package:deepy_wholesaler/page/deepy_home/home.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool? isAutoLoginChecked;
  late Map<String, dynamic> loginResponse;

  HttpService httpservice = HttpService();
  late final SharedPreferences prefs;

  Future<void> initLoginController(context) async {
    httpservice.getToken();
    prefs = await SharedPreferences.getInstance();
    isAutoLoginChecked = prefs.getBool('isChecked');

    if (isAutoLoginChecked == null) {
      isAutoLoginChecked = false;
      await prefs.setBool('isChecked', false);
    }

    if (httpservice.isRefreshExpired()) {
      // refresh token 만료되면 오토로그인 풀리게
      await prefs.setBool('isChecked', false);
    }
    autoLogin().catchError((e) {
      throw e;
    });

    update();
  }

  void checkedAutoLogin() async {
    isAutoLoginChecked = !isAutoLoginChecked!;

    await prefs.setBool('isChecked', isAutoLoginChecked!);
    update();
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
}
