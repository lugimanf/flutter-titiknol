import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/apps/voucher/viewmodels/voucher_list.dart';
import 'package:titiknol/pkg/helpers/widget_helper.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({super.key});

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  void _goToDetailVoucher() {
    // Get.to(() => const DetailBook(), arguments: data);
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
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            final voucher = voucherListViewModel.vouchers[index];
            return GestureDetector(
              onTap: _goToDetailVoucher,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias, // biar radius kepotong rapi
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5),
                    // 🖼️ Bagian gambar proporsional & tidak terpotong
                    AspectRatio(
                      aspectRatio: 4 / 3, // ubah jadi 1 kalau mau persegi
                      child: Container(
                        color: Colors.grey.shade200,
                        child: widgetHelper.createImage(
                          voucher.image,
                          double.infinity,
                          double.infinity,
                          // fit: BoxFit
                          //     .contain, // ⬅️ ini kuncinya: biar gambar utuh
                        ),
                      ),
                    ),

                    // 🧾 Bagian teks di bawah gambar
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 5),
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
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: listVouchers(widgetHelper, voucherListViewModel),
        ),
      ),
    );
  }
}
