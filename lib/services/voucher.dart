import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:async';

class VoucherService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> getVouchers(
      {int page = 1, int limit = 10}) async {
    httpHelper.setUrl(Urls.domain, Urls.vouchers);
    var response = await httpHelper
        .get(queryParams: {"limit": "10", "page": "1", "order_by": "id;desc"});
    return response;
  }

  Future<Map<String, dynamic>> getVoucherByID(int id) async {
    httpHelper.setUrl(Urls.domain, Urls.voucherByID + id.toString());
    var response = await httpHelper.get();
    return response;
  }
}
