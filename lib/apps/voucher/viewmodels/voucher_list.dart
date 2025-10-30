import 'package:get/get.dart';
import 'package:titiknol/services/voucher.dart';
import 'package:titiknol/models/voucher.dart';
import 'package:titiknol/pkg/helpers/exception_helper.dart';

class VoucherListViewModel extends GetxController {
  final VoucherService _voucherService = VoucherService();
  var vouchers = <Voucher>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVouchers();
  }

  Future<void> fetchVouchers() async {
    try {
      final response = await _voucherService.getVouchers();
      if (response.containsKey('message')) {
        throw Exception(response['message']); // lempar pesan error
      }
      final data = response['data']['vouchers'] as List;
      vouchers.assignAll(data.map((u) => Voucher.fromJson(u)).toList());
    } catch (e) {
      exceptionDialogBox(e);
    }
  }
}
