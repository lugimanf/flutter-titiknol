import 'package:titiknol/services/user.dart';

import 'package:titiknol/pkg/helpers/exception_helper.dart';

class FcmTokenViewModel {
  final UserService _userService = UserService();

  void updateFcmTOken(String fcmToken) async {
    try {
      final response = await _userService.updateFcmToken(fcmToken);
      if (response.containsKey('message')) {
        throw Exception(response['message']); // lempar pesan error
      }
    } catch (e) {
      exceptionDialogBox(e);
    }
  }
}
