import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:async';

class UserVoucherService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> fetchUserVouchers(
      {int page = 1, int limit = 10}) async {
    httpHelper.setUrl(Urls.domain, Urls.userVouchers);
    var response = await httpHelper.get(queryParams: {
      "limit": limit.toString(),
      "page": page.toString(),
      "order_by": "id;desc"
    });
    return response;
  }
}
