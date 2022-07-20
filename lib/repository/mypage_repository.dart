import 'dart:convert';

import 'package:deepy_wholesaler/repository/http_repository.dart';

class MypageRepository extends HttpRepository {
  late Map response;
  Map<String, String> queryParams = {};

  Future<dynamic> getMyproducts() async {
    response = await super.httpGet("products");
    return response['data'];
  }

  Future<dynamic> getUserInfo() async {
    response = await super.httpGet("users/wholesalers");

    return response['data'];
  }

  Future<dynamic> searchProducts(String searchWord) async {
    queryParams = {};
    if (searchWord.isNotEmpty) {
      queryParams['search_word'] = searchWord;
    }

    response = await super.httpGet("products", queryParams).catchError((e) {
      throw e;
    });

    return response['data'];
  }

  Future<dynamic> patchUserInfo(Map body) async {
    try {
      response = await super.httpPatch("users/wholesalers", jsonEncode(body));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
