import 'package:get/get.dart';
import 'package:titiknol/apps/voucher/viewmodels/voucher_list.dart';
import 'package:titiknol/apps/voucher/viewmodels/user_voucher.dart';
import 'package:titiknol/services/voucher.dart';
import 'package:titiknol/services/user_voucher.dart';
import 'package:titiknol/models/voucher.dart';
import 'package:titiknol/pkg/helpers/exception_helper.dart';

class VoucherDetailViewModel extends GetxController {
  final VoucherService _voucherService = VoucherService();
  final UserVoucherService _userVoucherService = UserVoucherService();
  final int id;
  var voucher = Voucher().obs;

  VoucherDetailViewModel(this.id);

  @override
  void onInit() {
    super.onInit();
    fetchVoucherByID(id);
  }

  Future<void> fetchVoucherByID(int id) async {
    try {
      final response = await _voucherService.getVoucherByID(id);
      if (response.containsKey('message')) {
        throw Exception(response['message']); // lempar pesan error
      }
      voucher.value = Voucher.fromJson(response['data']);
    } catch (e) {
      exceptionDialogBox(e);
    }
  }

  Future<Map<String, dynamic>> insertVoucher(int id) async {
    try {
      final response = await _userVoucherService.insertVoucher(id);
      if (response['status'] != "success") {
        throw Exception(response['message']); // lempar pesan error
      }
      final voucherListViewModel = Get.find<VoucherListViewModel>();
      final userVoucherViewModel = Get.find<UserVoucherViewModel>();
      await voucherListViewModel.fetchUser();
      userVoucherViewModel.resetPagination();
      await userVoucherViewModel.fetchUserVouchers();
      return {"status": true};
    } catch (e) {
      return {"status": false, "message": e};
    }
  }
}
