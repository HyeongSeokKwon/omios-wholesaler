import 'package:deepy_wholesaler/repository/http_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends HttpRepository {
  Future<dynamic> basicLogin(String id, String password) async {
    Map response;
    pref = await SharedPreferences.getInstance();

    Map<String, String> body = {
      'username': id,
      'password': password,
    };

    try {
      response = await super.httpPost('/token/', body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
