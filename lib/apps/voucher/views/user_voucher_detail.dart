import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:titiknol/pkg/helpers/widget_helper.dart';
import 'package:titiknol/models/user_voucher.dart';

class UserVoucherDetail extends StatefulWidget {
  const UserVoucherDetail({super.key});

  @override
  State<UserVoucherDetail> createState() => _UserVoucherDetailState();
}

class _UserVoucherDetailState extends State<UserVoucherDetail> {
  late final WidgetHelper widgetHelper;

  @override
  Widget build(BuildContext context) {
    final UserVoucher userVoucher = Get.arguments;
    widgetHelper = WidgetHelper(context);

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                bottom: 100), // beri jarak agar tidak ketutup tombol
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Gambar full width
                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: widgetHelper.createImage(
                //     userVoucher.image,
                //     widgetHelper.widthScreen,
                //     widgetHelper.heightScreen * 0.3,
                //   ),
                // ),
                const SizedBox(height: 20),
                Center(
                  child: widgetHelper.textLabel(userVoucher.name),
                ),
                const SizedBox(height: 20),
                Center(
                  child: QrImageView(
                    data: userVoucher.code, // ← QRIS string kamu
                    version: QrVersions.auto,
                    size: widgetHelper.widthScreen * 0.9,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: widgetHelper.textLabel(userVoucher.code)),
              ],
            ),
          )),
    );
  }
}
