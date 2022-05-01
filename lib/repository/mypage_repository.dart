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
    await super.getToken();
    int id = Jwt.parseJwt(super.accessToken!)['user_id'];

    response = await super.httpGet("users/wholesalers/$id");
    print(response);
    return response['data'];
  }

  Future<dynamic> getProductInfo() async {}
}
