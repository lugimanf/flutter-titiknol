import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/pkg/helpers/widget_helper.dart';
import 'package:titiknol/apps/home/viewmodels/home.dart';

class WidgetUserInfo {
  late double wCardBox, hCardBox;
  late WidgetHelper widgetHelper;
  BuildContext context;

  WidgetUserInfo(this.context) {
    init();
  }

  void init() {
    widgetHelper = WidgetHelper(context);
    wCardBox = widgetHelper.widthScreen * 0.3;
    hCardBox = widgetHelper.heightScreen * 0.1;
  }

  Widget userInfo() {
    HomeViewModel homeViewModel = Get.find();
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // samakan 8
      ),
      clipBehavior: Clip.antiAlias, // tambahan supaya clip ikut jalan
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black, // background hitam
            border: Border.all(
              color: const Color(0xFFD7BE9D), // border warna emas
              width: 2.0, // ketebalan border, bisa disesuaikan
            ),
            borderRadius:
                BorderRadius.circular(8), // opsional, agar sudut membulat
          ),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome ${homeViewModel.user.value.firstName.capitalize}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: Color(0xFFE0E0E0),
                  ),
                ),
                Text(
                  "Point: ${homeViewModel.user.value.point}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            );
          })),
    );
  }
}
