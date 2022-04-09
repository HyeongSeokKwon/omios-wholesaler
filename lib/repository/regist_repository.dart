import 'dart:convert';

import 'package:deepy_wholesaler/repository/http_repository.dart';
import 'package:dio/dio.dart';

class RegistRepository extends HttpRepository {
  late Map response;
  late Map<String, dynamic> queryParams;

  Future<dynamic> getCategoryInfo() async {
    response = await super.httpGet("products/categories");
    return response['data'];
  }

  Future<dynamic> getRegistryData([int? subCategoryId]) async {
    if (subCategoryId != null) {
      queryParams = {};
      queryParams['sub_category'] = subCategoryId.toString();
      response = await super.httpGet("products/registry-data", queryParams);
    } else {
      response = await super.httpGet("products/registry-data");
    }
    return response['data'];
  }

  Future<dynamic> registImage(List<dynamic> basicImagePathList) async {
    var formData = FormData.fromMap({
      'image': List.generate(basicImagePathList.length,
          (index) => MultipartFile.fromFileSync(basicImagePathList[index]!))
    });
    var res = await super.httpMultipartPost("products/images", formData, true);

    var response = res.data;

    return response['data']['image'];
  }

  Future<dynamic> registProduct(Map body) async {
    response = await super.httpPost("products", json.encode(body));
  }

  Future<dynamic> getTags(String tag) async {
    queryParams = {};
    queryParams['search_word'] = tag;
    response = await super.httpGet("products/tags", queryParams);
    return response['data'];
  }

  Future<dynamic> updateProduct(Map body, int productId) async {
    response = await super.httpPatch("products/$productId", json.encode(body));
  }
}
