import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:convert';
import 'dart:async';

class UserService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> getUser() async {
    httpHelper.setUrl(Urls.domain, Urls.user);
    var response = await httpHelper.get();
    return response;
  }

  Future<Map<String, dynamic>> updateFcmToken(String fcmToken) async {
    var payload = {
      "fcm_token": fcmToken,
    };
    httpHelper.setUrl(Urls.domain, Urls.userUpdateFcmToken);
    httpHelper.setBody(jsonEncode(payload));
    var response = await httpHelper.patch();
    return response;
  }
}
