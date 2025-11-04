import 'dart:async';
import 'dart:convert';

import 'package:titiknol/pkg/app_config.dart';
import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';

class UserVoucherService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> fetchUserVouchers(
      {int page = 1, int limit = 10}) async {
    httpHelper.setUrl(AppConfig.url!.domain, Urls.userVouchers);
    var response = await httpHelper.get(queryParams: {
      "limit": limit.toString(),
      "page": page.toString(),
      "order_by": "id;desc"
    });
    return response;
  }

  Future<Map<String, dynamic>> insertVoucher(int voucherID) async {
    var payload = {
      "voucher_id": voucherID,
    };
    httpHelper.setUrl(AppConfig.url!.domain, Urls.insertVoucher);
    httpHelper.setBody(jsonEncode(payload));
    var response = await httpHelper.post();
    return response;
  }
}
