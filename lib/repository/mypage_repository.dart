import 'package:deepy_wholesaler/repository/http_repository.dart';
import 'package:jwt_decode/jwt_decode.dart';

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
}
