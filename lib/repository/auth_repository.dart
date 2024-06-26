import 'dart:convert';

import 'package:deepy_wholesaler/repository/http_repository.dart';

class AuthRepository extends HttpRepository {
  late Map response;

  Future<dynamic> basicLogin(String id, String password) async {
    Map<String, String> body = {
      'username': id,
      'password': password,
    };

    try {
      response = await super.httpPost('users/tokens', json.encode(body));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> autoLogin(String refreshToken) async {
    Map<String, String> body = {
      'refresh': refreshToken,
    };

    try {
      response =
          await super.httpPost('users/tokens/refresh', json.encode(body));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
