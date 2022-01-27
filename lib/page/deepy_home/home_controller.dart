import 'package:deepy_wholesaler/http/http_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HttpService httpService = HttpService();
  Map<String, String> queryParams = {};
  List<dynamic> productData = [];

  Future<dynamic> initWholeSalerProducts() async {
    dynamic response;
    queryParams['main_category'] = '1';
    response =
        await httpService.httpGet("product", queryParams).catchError((e) {
      throw e;
    });

    productData = response['data']['results'];
    update();
    return response['data']['results'];
  }
}
