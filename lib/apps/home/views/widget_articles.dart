import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/pkg/helpers/widget_helper.dart';
import 'package:titiknol/apps/home/viewmodels/home.dart';

class WidgetArticles {
  late double wCardBox, hCardBox;
  late WidgetHelper widgetHelper;
  BuildContext context;

  WidgetArticles(this.context) {
    init();
  }

  void init() {
    widgetHelper = WidgetHelper(context);
    wCardBox = widgetHelper.widthScreen * 0.3;
    hCardBox = widgetHelper.heightScreen * 0.1;
  }

  void _goToDetailBook() {
    // Get.to(() => const DetailBook(), arguments: data);
  }

  // void _gotToListBooks() {
  //   Get.to(() => const ListBooks());
  // }

  Widget listFeaturedArticles() {
    HomeViewModel homeViewModel = Get.find();
    return Obx(() {
      int articleLength = homeViewModel.articles.length;
      if (articleLength == 0) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            shrinkWrap: true, // penting agar tidak konflik dengan scroll luar
            physics:
                const ClampingScrollPhysics(), // biar scroll luar yang aktif
            itemCount: articleLength,
            itemBuilder: (context, index) {
              final article = homeViewModel.articles[index];
              return GestureDetector(
                onTap: () {
                  _goToDetailBook();
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      widgetHelper.createImage(
                          article.image, wCardBox, hCardBox),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            // Text("Created at: ${article.created_at}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  Widget homeArticles() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Berita",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 24),
              child: Text(
                "Discover More",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                  color: Color(0xFFFFD700),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: listFeaturedArticles(),
        )
      ],
    );
  }
}
