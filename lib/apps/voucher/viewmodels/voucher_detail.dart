import 'package:get/get.dart';
import 'package:titiknol/services/voucher.dart';
import 'package:titiknol/models/voucher.dart';
import 'package:titiknol/pkg/helpers/exception_helper.dart';

class VoucherDetailViewModel extends GetxController {
  final VoucherService _voucherService = VoucherService();
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
}
