import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/apps/voucher/views/voucher_detail.dart';
import 'package:titiknol/apps/voucher/viewmodels/voucher_list.dart';
import 'package:titiknol/models/voucher.dart';
import 'package:titiknol/pkg/helpers/widget_helper.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  void _goToDetailVoucher(Voucher data) {
    Get.to(() => const VoucherDetail(), arguments: data);
  }

  Widget listVouchers(
      WidgetHelper widgetHelper, VoucherListViewModel voucherListViewModel) {
    return Obx(() {
      int voucherLength = voucherListViewModel.vouchers.length;
      if (voucherLength == 0) {
        return const Center(child: CircularProgressIndicator());
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

            // logika harga
            final bool hasDiscount = voucher.discountInPercent > 0;
            final double price = voucher.price;
            final double discountPrice = voucher.discountPrice;

            return GestureDetector(
              onTap: () => _goToDetailVoucher(voucher),
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
                      aspectRatio: 4 / 3,
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
                      child: hasDiscount
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '${discountPrice.toStringAsFixed(0)} pts',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${price.toStringAsFixed(0)} pts',
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
                              '${price.toStringAsFixed(0)} pts',
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
    final widgetHelper = WidgetHelper(context);
    VoucherListViewModel voucherListViewModel = Get.put(VoucherListViewModel());

    return RefreshIndicator(
        onRefresh: () async {
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
                    "Your Points",
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
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: listVouchers(widgetHelper, voucherListViewModel),
                ),
              ),
            ),
          ],
        ));
  }
}
