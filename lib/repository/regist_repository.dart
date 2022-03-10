import 'package:deepy_wholesaler/repository/http_repository.dart';

class RegistRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getCategoryInfo() async {
    response = await super.httpGet("product/category/");
    return response['data'];
  }

  Future<dynamic> getRegistryCommon() async {
    response = await super.httpGet("product/registry-common/");
    return response['data'];
  }

  Future<dynamic> getRegistryDynamic(int subCategoryId) async {
    queryParams = {};
    queryParams['sub_category'] = subCategoryId.toString();
    response = await super.httpGet("product/registry-dynamic", queryParams);

    return response['data'];
  }
}
