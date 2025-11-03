import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/const/fonts.dart' as const_fonts;
import 'package:titiknol/pkg/helpers/exception_helper.dart';
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:titiknol/pkg/views/loading_overlay/loading_overlay.dart';
import 'package:titiknol/pkg/helpers/widget_helper.dart';
import 'package:titiknol/apps/voucher/views/voucher.dart' as voucher_view;
import 'package:titiknol/apps/voucher/viewmodels/voucher_detail.dart';

class VoucherDetail extends StatefulWidget {
  const VoucherDetail({super.key});

  @override
  State<VoucherDetail> createState() => _VoucherDetailState();
}

class _VoucherDetailState extends State<VoucherDetail> {
  late final VoucherDetailViewModel voucherDetailViewModel;
  late final WidgetHelper widgetHelper;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;
    widgetHelper = WidgetHelper(context);

    // Inject controller
    voucherDetailViewModel =
        Get.put(VoucherDetailViewModel(data['voucher_id']));

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          const_labels.titleMenuDetailVoucher,
          style: TextStyle(color: Colors.white),
        ),
      ),

      // 🔹 Body scrollable
      body: MainContainer(
        background: "transparant",
        useMargin: false,
        child: Obx(() {
          if (voucherDetailViewModel.voucher.value.id == 0) {
            return const Center(child: CircularProgressIndicator());
          }

          final voucher = voucherDetailViewModel.voucher.value;

          return SingleChildScrollView(
            padding: const EdgeInsets.only(
                bottom: 100), // beri jarak agar tidak ketutup tombol
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Gambar full width
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: widgetHelper.createImage(
                    voucher.image,
                    widgetHelper.widthScreen,
                    widgetHelper.heightScreen * 0.3,
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Harga
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: voucher.finalPrice != voucher.price
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${voucher.finalPrice.toStringAsFixed(0)} pts',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontFamily: const_fonts.fontFamilyUsed,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${voucher.price.toStringAsFixed(0)} pts',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          '${voucher.finalPrice.toStringAsFixed(0)} pts',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: const_fonts.fontFamilyUsed,
                          ),
                        ),
                ),

                const SizedBox(height: 10),

                // 🔹 Nama voucher
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    voucher.name,
                    style: const TextStyle(
                      fontSize: const_fonts.fontSizeTitle,
                      fontWeight: FontWeight.w700,
                      fontFamily: const_fonts.fontFamilyUsed,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Deskripsi (optional)
                if (voucher.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      voucher.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),

      // 🔹 Tombol selalu di bawah (sticky)
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              // 🔹 kalau poin cukup => bisa diklik, kalau tidak => null (disable)
              onPressed: data['can_exchange']
                  ? () async {
                      Get.back();
                    }
                  : () async {
                      Get.defaultDialog(
                        title: const_labels.dialogTitleConfirmation,
                        middleText: const_labels.dialogExchangeAskConfirmation,
                        textCancel: const_labels.dialogButtonCancel,
                        textConfirm: const_labels.dialogButtonExchange,
                        confirmTextColor: Colors.white,
                        buttonColor: Colors.green,
                        onCancel: () {
                          Get.back();
                          Get.back();
                        },
                        onConfirm: () async {
                          Get.back();
                          LoadingOverlay.of(context).show(
                              message: const_labels
                                  .textWaitingProcessExchangeVoucher);
                          voucherDetailViewModel
                              .insertVoucher(data['voucher_id'])
                              .then((response) {
                            if (response['status'] == "success") {
                              Get.back();
                              Get.snackbar(
                                const_labels.successProcess,
                                const_labels.successGetVoucher,
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                              final voucherTabController =
                                  Get.find<voucher_view.VoucherTabController>();
                              voucherTabController.changeTab(0);
                            } else {
                              throw Exception(response['message']);
                            }
                          }).catchError((e) {
                            exceptionDialogBox(e, title: "warning");
                          }).whenComplete(() {
                            LoadingOverlay.of(context).hide();
                          });
                        },
                      );
                    }, // 🔹 null artinya disabled di ElevatedButton

              // 🔹 ubah warna tombol sesuai kondisi
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    data['can_exchange'] ? Colors.grey.shade700 : Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              // 🔹 ubah juga teksnya biar user paham
              child: Text(
                data['can_exchange']
                    ? const_labels.buttonExchangePointNotEnough
                    : const_labels.buttonExchange,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
