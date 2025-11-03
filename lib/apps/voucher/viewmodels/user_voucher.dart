import 'package:get/get.dart';
import 'package:titiknol/services/user_voucher.dart';
import 'package:titiknol/models/user_voucher.dart';
import 'package:titiknol/pkg/helpers/exception_helper.dart';

class UserVoucherViewModel extends GetxController {
  final UserVoucherService _voucherService = UserVoucherService();
  var userVouchers = <UserVoucher>[].obs;
  var isLoadingMore = false.obs;
  var page = 1;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchUserVouchers();
  }

  Future<void> fetchUserVouchers() async {
    try {
      if (isLoadingMore.value) return;
      isLoadingMore.value = true;
      final response =
          await _voucherService.fetchUserVouchers(page: page, limit: limit);
      if (response.containsKey('message')) {
        throw Exception(response['message']); // lempar pesan error
      }
      final data = response['data']['user_vouchers'] as List;
      if (data.isNotEmpty) {
        userVouchers.addAll(data.map((u) => UserVoucher.fromJson(u)).toList());
        page++;
      }
      isLoadingMore.value = false;
    } catch (e) {
      exceptionDialogBox(e);
    }
  }
}
