import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:async';

import 'package:titiknol/models/articles_response.dart';

class HomeService {
  final HttpHelper httpHelper = HttpHelper();

  Future<ArticlesResponse> getFeaturedByVellux() async {
    httpHelper.setUrl(Urls.domain, Urls.articles);
    var data = await httpHelper
        .get(queryParams: {"limit": "10", "page": "1", "order_by": "id;desc"});
    final articlesResponse = ArticlesResponse.fromJson(data);
    return articlesResponse;
  }
}
