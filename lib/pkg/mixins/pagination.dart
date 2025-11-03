import 'package:get/get.dart';

mixin PaginationMixin<T> {
  var isLoadingMore = false.obs;
  int page = 1;
  var items = <T>[].obs;
  int limit = 10;

  void resetPagination() {
    isLoadingMore.value = false;
    page = 1;
    items.clear();
  }
}
