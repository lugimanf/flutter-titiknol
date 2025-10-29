import 'package:get/get.dart';
import 'package:titiknol/services/home.dart';
import 'package:titiknol/services/user.dart';
import 'package:titiknol/models/article.dart';
import 'package:titiknol/models/user.dart';

class HomeViewModel extends GetxController {
  final HomeService _homeService = HomeService();
  final UserService _userService = UserService();
  var articleList = <Article>[].obs;
  var user = User().obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
    fetchUser();
  }

  Future<void> fetchArticles() async {
    try {
      final response = await _homeService.getFeaturedByVellux();
      articleList.assignAll(response.articles);
    } catch (e) {
      Get.defaultDialog(
        title: "Info",
        middleText: "Something went wrong: $e",
        textConfirm: "OK",
        onConfirm: () => Get.back(),
      );
    }
  }

  Future<void> fetchUser() async {
    try {
      final response = await _userService.getUser();
      user.value = response;
    } catch (e) {
      Get.defaultDialog(
        title: "Info",
        middleText: "Something went wrong: $e",
        textConfirm: "OK",
        onConfirm: () => Get.back(),
      );
    }
  }
}
