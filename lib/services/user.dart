import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:async';

class UserService {
  final HttpHelper httpHelper = HttpHelper();

  Future<Map<String, dynamic>> getUser() async {
    httpHelper.setUrl(Urls.domain, Urls.user);
    var response = await httpHelper.get();
    return response;
  }
}
