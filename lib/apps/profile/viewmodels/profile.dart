import 'package:get/get.dart';
import 'package:titiknol/services/user.dart';
import 'package:titiknol/models/user.dart';
import 'package:titiknol/pkg/helpers/exception_helper.dart';

class ProfileViewModel extends GetxController {
  final UserService _userService = UserService();
  var user = User().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final response = await _userService.getUser();
      if (response.containsKey('message')) {
        throw Exception(response['message']); // lempar pesan error
      }
      user.value = User.fromJson(response['data']);
    } catch (e) {
      exceptionDialogBox(e);
    }
  }
}
