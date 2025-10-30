import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:async';

class HomeService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> getArticles() async {
    httpHelper.setUrl(Urls.domain, Urls.articles);
    var response = await httpHelper
        .get(queryParams: {"limit": "10", "page": "1", "order_by": "id;desc"});
    return response;
  }
}
