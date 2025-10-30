import 'package:get/get.dart';
import 'package:titiknol/services/home.dart';
import 'package:titiknol/services/user.dart';
import 'package:titiknol/models/article.dart';
import 'package:titiknol/models/user.dart';
import 'package:titiknol/pkg/helpers/exception_helper.dart';

class HomeViewModel extends GetxController {
  final HomeService _homeService = HomeService();
  final UserService _userService = UserService();
  var articles = <Article>[].obs;
  var user = User().obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
    fetchUser();
  }

  Future<void> fetchArticles() async {
    try {
      final response = await _homeService.getArticles();
      if (response.containsKey('message')) {
        throw Exception(response['message']); // lempar pesan error
      }
      final data = response['data']['articles'] as List;
      articles.assignAll(data.map((u) => Article.fromJson(u)).toList());
    } catch (e) {
      exceptionDialogBox(e);
    }
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
