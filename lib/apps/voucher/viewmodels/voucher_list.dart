import 'package:get/get.dart';
import 'package:titiknol/pkg/helpers/debug_helper.dart';
import 'package:titiknol/services/voucher.dart';
import 'package:titiknol/services/user.dart';
import 'package:titiknol/models/user.dart';
import 'package:titiknol/models/voucher.dart';
import 'package:titiknol/pkg/helpers/exception_helper.dart';

class VoucherListViewModel extends GetxController {
  final VoucherService _voucherService = VoucherService();
  final UserService _userService = UserService();
  var vouchers = <Voucher>[].obs;
  var isLoadingMore = false.obs;
  var user = User().obs;
  var page = 1;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
    fetchVouchers();
  }

  Future<void> fetchVouchers() async {
    try {
      if (isLoadingMore.value) return;
      isLoadingMore.value = true;
      printDebug(page);
      final response =
          await _voucherService.getVouchers(page: page, limit: limit);
      if (response.containsKey('message')) {
        throw Exception(response['message']); // lempar pesan error
      }
      final data = response['data']['vouchers'] as List;
      if (data.isNotEmpty || page == 1) {
        vouchers.addAll(data.map((u) => Voucher.fromJson(u)).toList());
        page++;
      }
      isLoadingMore.value = false;
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
