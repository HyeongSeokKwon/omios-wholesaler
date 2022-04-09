import 'package:deepy_wholesaler/repository/http_repository.dart';

class EditRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getSalerProductInfo(int productId) async {
    response = await super.httpGet("products/$productId");
    return response['data'];
  }
}
