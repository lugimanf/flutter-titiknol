import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/apps/voucher/views/voucher_detail.dart';
import 'package:titiknol/apps/voucher/viewmodels/voucher_list.dart';
import 'package:titiknol/models/voucher.dart';
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/helpers/widget_helper.dart';
import 'package:titiknol/pkg/views/loading_overlay/loading_overlay.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  final ScrollController _scrollController = ScrollController();
  late WidgetHelper widgetHelper;
  late VoucherListViewModel voucherListViewModel;
  @override
  void initState() {
    super.initState();
    voucherListViewModel = Get.find();

    // Listener untuk pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !voucherListViewModel.isLoadingMore.value) {
        voucherListViewModel.fetchVouchers();
      }
    });

    // Load data awal
    voucherListViewModel.fetchVouchers();
  }

  void _goToDetailVoucher(Voucher voucher, int point) {
    final data = {
      "voucher_id": voucher.id,
      "can_exchange": voucher.finalPrice > point,
    };
    Get.to(() => const LoadingOverlay(child: VoucherDetail()), arguments: data);
  }

  Widget listVouchers() {
    return Obx(() {
      int voucherLength = voucherListViewModel.vouchers.length;
      if (voucherLength == 0) {
        return SizedBox(
          height: widgetHelper.heightScreen * 0.7, // ambil tinggi layar penuh
          width: double.infinity, // lebar penuh
          child: const Center(
            child: Text(const_labels.labelEmptyVoucherList),
          ),
        );
      } else {
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: voucherLength,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kolom per baris
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 3.7,
          ),
          itemBuilder: (context, index) {
            final voucher = voucherListViewModel.vouchers[index];

            return GestureDetector(
              onTap: () => _goToDetailVoucher(
                  voucher, voucherListViewModel.user.value.point),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 🖼️ Gambar
                    AspectRatio(
                      aspectRatio: 4 / 2.9,
                      child: Container(
                        color: Colors.grey.shade200,
                        child: widgetHelper.createImage(
                          voucher.image,
                          double.infinity,
                          double.infinity,
                        ),
                      ),
                    ),

                    // 🔤 Nama voucher (fix tinggi 2 baris agar konsisten)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 10, right: 10),
                      child: SizedBox(
                        height: 40, // 🔹 jaga tinggi tetap sama untuk 1-2 baris
                        child: Text(
                          voucher.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // 💰 Harga
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 4),
                      child: voucher.finalPrice != voucher.price
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '${voucher.finalPrice.toStringAsFixed(0)} pts',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 14,
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
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widgetHelper = WidgetHelper(context);

    return RefreshIndicator(
        onRefresh: () async {
          voucherListViewModel.vouchers.clear();
          voucherListViewModel.page = 1;
          await voucherListViewModel.fetchVouchers();
          await voucherListViewModel.fetchUser();
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.black87,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    const_labels.labelYourPoint,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Obx(() => Text(
                        "${voucherListViewModel.user.value.point} pts",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: listVouchers(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
