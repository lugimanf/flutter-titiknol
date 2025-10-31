import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:convert';
import 'dart:async';

class LoginService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> login(String email) async {
    var payload = {
      "email": email,
    };
    httpHelper.setUrl(Urls.domain, Urls.login);
    httpHelper.setBody(jsonEncode(payload));
    var response = await httpHelper.post();
    return response;
  }

  Future<Map<String, dynamic>> loginConfirmOtp(String otp, String token) async {
    var payload = {
      "otp": otp,
      "token": token,
    };
    httpHelper.setUrl(Urls.domain, Urls.loginConfirmOtp);
    httpHelper.setBody(jsonEncode(payload));
    var response = await httpHelper.post();
    return response;
  }
}
