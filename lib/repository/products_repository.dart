import 'package:deepy_wholesaler/repository/http_repository.dart';

class ProductsRepository extends HttpRepository {
  late Map response;
  late Map<String, String> queryParams;

  Future<dynamic> getMyproducts() async {
    queryParams = {};
    queryParams['main_category'] = '1';
    response = await super.httpPublicGet("product", queryParams);
    return response['data']['results'];
  }

  Future<dynamic> getProductInfo() async {}
}
