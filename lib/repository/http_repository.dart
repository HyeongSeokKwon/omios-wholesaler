import 'dart:convert';
import 'dart:io';
import 'package:deepy_wholesaler/http/http_exception.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpRepository {
  String? refreshToken;
  String? accessToken;

  String addressUrl = '13.209.244.41';
  late SharedPreferences pref;

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

      case 201:
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

      case 400:
        throw BadRequestException("400 :");

      case 401:
        var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson;

      case 403:
        throw UnauthorisedException("403 :");

      case 404:
        throw NotfoundException("404 :");

      case 500:
        throw FetchDataException("500 :");

      default:
        throw FetchDataException('');
    }
  }

  void getToken() async {
    pref = await SharedPreferences.getInstance();
    refreshToken = pref.getString('refreshToken');
    accessToken = pref.getString('accessToken');
  }

  Future<void> setRefreshToken(var changedRefreshToken) async {
    pref = await SharedPreferences.getInstance();
    pref.setString('refreshToken', changedRefreshToken);
    refreshToken = changedRefreshToken;
  }

  Future<void> setAccessToken(var changedAccessToken) async {
    pref = await SharedPreferences.getInstance();
    pref.setString('accessToken', changedAccessToken);
    accessToken = changedAccessToken;
  }

  bool isAccessExpired() {
    if (accessToken == null || Jwt.isExpired(accessToken!)) {
      return true;
    } else {
      return false;
    }
  }

  bool isRefreshExpired() {
    if (refreshToken == null || Jwt.isExpired(refreshToken!)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateToken() async {
    // refresh token으로 accessToken 갱신시키는 함수
    Map<String, dynamic> responseJson;
    getToken();
    if (isAccessExpired()) {
      //access token 만료 되었으면
      if (!isRefreshExpired()) {
        // refresh token 만료 되지 않았으면
        try {
          var response = await http.post(
            Uri.http(addressUrl, '/token/refresh/'), // refresh token 으로 재발급
            headers: {"Content-Type": "application/json; charset=UTF-8"},
            body: json.encode(
              {"refresh": refreshToken},
            ),
          );
          responseJson = _response(response);
          setAccessToken(responseJson['data']['access']);
          setRefreshToken(responseJson['data']['refresh']);
        } on SocketException {
          throw FetchDataException("연결된 인터넷이 없습니다.");
        }
      }
    }
  }

  Future<dynamic> httpGet(String baseUrl,
      [Map<String, dynamic>? queryParams]) async {
    http.Response response;
    var responseJson = {};
    try {
      response = await updateToken().then(((value) async {
        return await http.get(
          Uri.http(addressUrl, baseUrl, queryParams),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
        );
      }));
      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    } on FetchDataException {
      throw Exception("서버 오류가 발생했습니다!!");
    }
  }

  Future<dynamic> httpPublicGet(String baseUrl,
      [Map<String, String>? queryParams]) async {
    http.Response response;
    var responseJson = {};
    print(
      Uri.http(addressUrl, baseUrl, queryParams),
    );
    try {
      response = await http.get(Uri.http(addressUrl, baseUrl, queryParams));

      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("연결된 인터넷이 없습니다!!");
    }
  }

  Future<dynamic> httpPost(String addtionalUrl, var body) async {
    http.Response response;
    Map<String, dynamic> responseJson;

    try {
      response = await updateToken().then(((value) async {
        return await http.post(
            Uri.http(
              addressUrl,
              addtionalUrl,
            ),
            headers: {
              "Content-Type": "application/json",
              HttpHeaders.authorizationHeader: 'Bearer $accessToken'
            },
            body: body);
      }));
      print(response.body);
      responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('연결된 인터넷이 없습니다.');
    } on FetchDataException {
      throw Exception("서버 오류가 발생했습니다.");
    }
  }

  Future<dynamic> httpMultipartPost(String addtionalUrl, var body) async {
    Response response;

    try {
      response = await updateToken().then(((value) async {
        return await Dio().post(
          Uri.http(addressUrl, addtionalUrl).toString(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
            "Content-Type": "multipart/form-data;",
          }),
          data: body,
        );
      }));
      // response = await updateToken().then(((value) async {
      //   return await http.post(
      //       Uri.http(
      //         addressUrl,
      //         addtionalUrl,
      //       ),
      //       headers: {
      //         "Content-Type": "multipart/form-data",
      //         HttpHeaders.authorizationHeader: 'Bearer $accessToken'
      //       },
      //       body: body);
      // }));
      return response;
    } on SocketException {
      throw FetchDataException('연결된 인터넷이 없습니다.');
    } on FetchDataException {
      throw Exception("서버 오류가 발생했습니다.");
    }
  }

  Future<dynamic> httpPatch(String addtionalUrl) async {}

  Future<dynamic> httpDelete(String addtionalUrl) async {}
}
