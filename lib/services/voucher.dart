import 'dart:async';

import 'package:titiknol/pkg/app_config.dart';
import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';

class VoucherService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> getVouchers(
      {int page = 1, int limit = 10}) async {
    httpHelper.setUrl(AppConfig.url!.domain, Urls.vouchers);
    var response = await httpHelper.get(queryParams: {
      "limit": limit.toString(),
      "page": page.toString(),
      "order_by": "id;desc"
    });
    return response;
  }

  Future<Map<String, dynamic>> getVoucherByID(int id) async {
    httpHelper.setUrl(AppConfig.url!.domain, Urls.voucherByID + id.toString());
    var response = await httpHelper.get();
    return response;
  }
}
