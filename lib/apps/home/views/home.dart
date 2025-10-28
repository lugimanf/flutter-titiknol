import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:titiknol/apps/home/viewmodels/home.dart';
import 'package:titiknol/pkg/const/fonts.dart' as const_fonts;
import 'package:titiknol/pkg/const/assets.dart' as const_assets;
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/const/settings.dart' as const_settings;
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:titiknol/apps/home/views/widget_featured_by_vellux.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    final WidgetFeaturedByVellux widgetFeaturedByVellux =
        WidgetFeaturedByVellux(context);

    void action(String label) {
      switch (label) {
        case const_labels.buttonLibrary:
          Get.toNamed("/library");
          break;
      }
    }

    // Fungsi untuk membangun tombol
    Widget buildIconButton(String asset, label) {
      return IconButton(
        onPressed: () {
          action(label);
        },
        icon: Image.asset(asset,
            width: const_settings.iconButtonHeight -
                const_settings.reduceHeightIcon,
            height: const_settings.iconButtonHeight -
                const_settings.reduceHeightIcon),
        padding: const EdgeInsets.all(0.0),
      );
    }

    Widget buttonBento() {
      List<List<dynamic>> listButton = [
        [const_assets.iconTask, const_labels.buttonTask],
        [const_assets.iconEvent, const_labels.buttonEvent],
        [const_assets.iconCollection, const_labels.buttonStore],
      ];

      const int itemsPerRow = 4;
      const double horizontalPadding = 12;

      return LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double availableWidth = screenWidth - (horizontalPadding * 2);
          double itemWidth = availableWidth / itemsPerRow;

          List<Widget> rows = [];
          List<Widget> currentRow = [];

          for (var idx = 0; idx < listButton.length; idx++) {
            var item = listButton[idx];
            Widget button = SizedBox(
              width: itemWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildIconButton(item[0], item[1]),
                  const SizedBox(height: 4),
                  Text(
                    item[1],
                    style: const TextStyle(
                      fontFamily: const_fonts.fontFamilyUsed,
                      fontSize: const_fonts.fontSizeText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );

            currentRow.add(button);

            bool isEndOfRow = (idx + 1) % itemsPerRow == 0;
            bool isLastItem = idx == listButton.length - 1;

            if (isEndOfRow || isLastItem) {
              // Hitung nomor baris (0-based)
              int rowIndex = rows.length;

              MainAxisAlignment alignment;
              if (currentRow.length == itemsPerRow) {
                // Baris penuh (selalu spaceBetween)
                alignment = MainAxisAlignment.spaceBetween;
              } else {
                // Baris tidak penuh
                if (rowIndex == 0) {
                  // Baris pertama (tidak penuh) -> tombol rata merata
                  alignment = MainAxisAlignment.spaceEvenly;
                } else {
                  // Baris kedua ke atas (tidak penuh) -> rata kiri
                  alignment = MainAxisAlignment.start;
                }
              }

              rows.add(Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: currentRow,
                  mainAxisAlignment: alignment,
                ),
              ));
              currentRow = [];
            }
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: rows,
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        child: MainContainer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // samakan 8
                    ),
                    clipBehavior:
                        Clip.antiAlias, // tambahan supaya clip ikut jalan
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.black, // background hitam
                        border: Border.all(
                          color: const Color(0xFFD7BE9D), // border warna emas
                          width: 2.0, // ketebalan border, bisa disesuaikan
                        ),
                        borderRadius: BorderRadius.circular(
                            8), // opsional, agar sudut membulat
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "How can we help you?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                buttonBento(),
                widgetFeaturedByVellux.featuredByVellux(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
