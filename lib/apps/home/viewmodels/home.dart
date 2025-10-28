import 'package:get/get.dart';
import 'package:titiknol/services/home.dart';
import 'package:titiknol/models/article.dart';

class HomeViewModel extends GetxController {
  final HomeService _homeService = HomeService();
  var articleList = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
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
}
