import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/helpers/http_helper.dart';
import 'dart:async';

import 'package:titiknol/models/user.dart';

class UserService {
  final HttpHelper httpHelper = HttpHelper();

  Future<User> getUser() async {
    httpHelper.setUrl(Urls.domain, Urls.user);
    var data = await httpHelper.get();
    final userResponse = User.fromJson(data);
    return userResponse;
  }
}
