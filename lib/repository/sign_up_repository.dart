import 'dart:convert';

import 'package:deepy_wholesaler/repository/http_repository.dart';
import 'package:dio/dio.dart';

class SignUpRepository extends HttpRepository {
  late dynamic response;
  late Map<String, String> queryParams;

  Future<dynamic> getBuildingInfos() async {
    response = await super
        .httpPublicGet("users/wholesalers/buildings")
        .catchError((e) {
      throw e;
    });
    return response['data'];
  }

  Future<dynamic> getIdUnique(String id) async {
    queryParams = {};
    queryParams['username'] = id;
    response = await super.httpPublicGet("users/unique", queryParams);
    return response['data']['is_unique'];
  }

  Future<dynamic> registusinessRegistrationImage(String imagePath) async {
    queryParams = {};
    var formData = FormData.fromMap({
      'image': [MultipartFile.fromFileSync(imagePath)]
    });

    response = await super.httpMultipartPost(
        'users/wholesalers/business_registration_images', formData, false);

    return response.data['data']['image'][0];
  }

  Future<dynamic> signUpRequest(Map body) async {
    response =
        await super.httpPublicPost('users/wholesalers', json.encode(body));

    print(response);
    return response;
  }
}
