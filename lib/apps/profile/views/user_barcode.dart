import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:titiknol/pkg/helpers/widget_helper.dart';

class UserBarcode extends StatefulWidget {
  const UserBarcode({super.key});

  @override
  State<UserBarcode> createState() => _UserBarcodeState();
}

class _UserBarcodeState extends State<UserBarcode> {
  late final WidgetHelper widgetHelper;

  @override
  Widget build(BuildContext context) {
    final int userID = Get.arguments;
    widgetHelper = WidgetHelper(context);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          "",
          style: TextStyle(color: Colors.white),
        ),
      ),

      // 🔹 Body scrollable
      body: MainContainer(
        background: "transparant",
        useMargin: false,
        child: SingleChildScrollView(
          child: SizedBox(
            height: widgetHelper.heightScreen * 0.75,
            width: double.infinity,
            child: Center(
              child: QrImageView(
                data: base64Encode(utf8.encode(userID.toString())),
                version: QrVersions.auto,
                size: widgetHelper.widthScreen * 0.9,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ),
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
              onPressed: () async {
                Get.back();
              }, // 🔹 null artinya disabled di ElevatedButton

              // 🔹 ubah warna tombol sesuai kondisi
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              // 🔹 ubah juga teksnya biar user paham
              child: Text(
                const_labels.buttonBack,
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
