import 'dart:convert';

import 'package:deepy_wholesaler/repository/http_repository.dart';
import 'package:dio/dio.dart';

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
    response = await super.httpGet("product/registry-dynamic/", queryParams);

    return response['data'];
  }

  Future<dynamic> registImage(List<dynamic> basicImagePathList) async {
    var formData = FormData.fromMap({
      'image': List.generate(basicImagePathList.length,
          (index) => MultipartFile.fromFileSync(basicImagePathList[index]!))
    });
    var res = await super.httpMultipartPost("product/image/", formData);

    var response = res.data;

    return response['data']['image'];
  }

  Future<dynamic> registProduct(Map body) async {
    response = await super.httpPost("product/", json.encode(body));
  }

  Future<dynamic> getTags(String tag) async {
    queryParams = {};
    queryParams['query'] = tag;
    response = await super.httpGet("product/tag/", queryParams);
    return response['data'];
  }
}
