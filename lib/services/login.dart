import 'dart:convert';
import 'dart:async';

import 'package:titiknol/pkg/app_config.dart';
import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';

class LoginService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> login(String email) async {
    var payload = {
      "email": email,
    };
    httpHelper.setUrl(AppConfig.url!.domain, Urls.login);
    httpHelper.setBody(jsonEncode(payload));
    var response = await httpHelper.post();
    return response;
  }

  Future<Map<String, dynamic>> loginConfirmOtp(String otp, String token) async {
    var payload = {
      "otp": otp,
      "token": token,
    };
    httpHelper.setUrl(AppConfig.url!.domain, Urls.loginConfirmOtp);
    httpHelper.setBody(jsonEncode(payload));
    var response = await httpHelper.post();
    return response;
  }
}
