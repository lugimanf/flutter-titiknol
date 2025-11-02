import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:async';
import 'dart:convert';

class UserVoucherService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> insertVoucher(int voucherID) async {
    var payload = {
      "voucher_id": voucherID,
    };
    httpHelper.setUrl(Urls.domain, Urls.insertVoucher);
    httpHelper.setBody(jsonEncode(payload));
    var response = await httpHelper.post();
    return response;
  }
}
