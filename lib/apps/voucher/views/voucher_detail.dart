import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/const/fonts.dart' as const_fonts;
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:titiknol/pkg/helpers/widget_helper.dart';
import 'package:titiknol/models/voucher.dart';
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
    final Voucher data = Get.arguments;
    widgetHelper = WidgetHelper(context);

    // Inject controller
    voucherDetailViewModel = Get.put(VoucherDetailViewModel(data.id));

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
                  child: Text(
                    '${voucher.price.toStringAsFixed(0)} pts',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
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
          color: Colors.black, // 🔹 background hitam
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // TODO: tambah aksi redeem nanti
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // 🔹 tombol warna hijau
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Change',
                style: TextStyle(
                  color: Colors.white, // teks putih biar kontras
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
