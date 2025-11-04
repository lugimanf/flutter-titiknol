import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/pkg/helpers/widget_helper.dart';
import 'package:titiknol/apps/home/viewmodels/home.dart';
import 'package:titiknol/pkg/globals/globals.dart' as globals;

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
                /// 🔹 Bagian atas: emblem + nama + point
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🛡️ Emblem
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        globals.medalAsset[homeViewModel.user.value.rankID - 1],
                        width: 48,
                        height: 48,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // 🔤 Nama + Point
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${homeViewModel.user.value.firstName.capitalize} ${homeViewModel.user.value.lastName.capitalize}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                        Text(
                          "Point: ${homeViewModel.user.value.point} pts",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// 🔹 Bar level di bawah
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔸 Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.5, // contoh: 0.45 berarti 45%
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade800,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // 🔸 Info level
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Level ${homeViewModel.user.value.level}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "${(0.5 * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
