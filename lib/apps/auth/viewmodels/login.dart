import 'package:titiknol/services/login.dart';
import 'package:get/get.dart';

import 'package:titiknol/pkg/storage/shared_preferences.dart';
import 'package:titiknol/pkg/const/keys.dart' as const_keys;
import 'package:titiknol/pkg/globals/globals.dart' as globals;
import 'package:titiknol/apps/auth/viewmodels/fcm_token.dart';

class LoginViewModel extends GetxController {
  final LoginService _loginService = LoginService();
  final prefs = SharedPreferencesHelper();
  RxBool isLoading = false.obs;
  RxBool isGetOTP = false.obs;
  RxString messageLogin = "".obs;
  RxString messageRegister = "".obs;
  RxString token = "".obs;

  void login(Map<String, dynamic> formData) async {
    isLoading.value = true;
    messageLogin.value = "";

    try {
      final response = await _loginService.login(formData['email']);
      if (response.containsKey('data')) {
        token(response['data']['token']);
        isGetOTP(true);
      } else if (response.containsKey('message')) {
        messageLogin(response['message']);
      }
    } finally {
      isLoading(false);
    }
  }

  void loginConfirmOtp(String otp, String token) async {
    final FcmTokenViewModel fcmTokenViewModel = FcmTokenViewModel();
    bool login = false;
    isLoading.value = true;
    messageLogin.value = "";

    try {
      final response = await _loginService.loginConfirmOtp(otp, token);
      if (response.containsKey('data')) {
        login = true;
        prefs.setString(const_keys.jwtToken, response['data']['token']);
        globals.token = response['data']['token'];
        fcmTokenViewModel.updateFcmTOken(globals.fcmToken!);
      } else if (response.containsKey('message')) {
        messageLogin(response['message']);
      }
    } finally {
      isLoading(false);
    }

    if (login) {
      Get.offAllNamed("/mainMenu");
    }
  }
}
