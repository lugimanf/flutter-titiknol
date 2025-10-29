import 'package:get/get.dart';
import 'package:titiknol/services/voucher.dart';
import 'package:titiknol/models/voucher.dart';

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
      final response = await _voucherService.GetVouchers();
      final data = response['data'] as List;
      vouchers.assignAll(data.map((u) => Voucher.fromJson(u)).toList());
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
