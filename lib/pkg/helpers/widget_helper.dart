import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:titiknol/pkg/const/fonts.dart' as const_fonts;

class WidgetHelper {
  late double widthScreen, heightScreen;
  BuildContext context;

  WidgetHelper(this.context) {
    init();
  }

  void init() {
    widthScreen = MediaQuery.sizeOf(context).width;
    heightScreen = MediaQuery.sizeOf(context).height;
  }

  Widget textLabel(String text, {double height = 0, double width = 0}) {
    return Text(text,
        style: const TextStyle(fontFamily: const_fonts.fontFamilyUsed));
  }

  Widget createSpacedBox({double height = 0, double width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Widget createImage(String url, double wCard, hCard,
      {double borderRadius = 0, BoxFit fit = BoxFit.cover}) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          width: wCard,
          height: hCard,
          fit: fit,
          imageUrl: url,
          placeholder: (context, url) => const SizedBox(
              width: 10,
              height: 10,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fadeInDuration: const Duration(milliseconds: 500),
        ));
  }

  Widget createLoadingCard(int number, double wCardBox, hCardBox) {
    Widget cardLoading = Container(
      decoration: BoxDecoration(
        // color: Colors.blueAccent, // Optional: Background color
        border: Border.all(
          color: Colors.black12, // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      width: wCardBox,
      height: hCardBox,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
    );
    List<Widget> widgets = [];
    for (var i = 0; i < number; i++) {
      widgets.add(cardLoading);
      widgets.add(createSpacedBox(width: 5));
    }

    Widget listView = SizedBox(
        height: hCardBox,
        width: widthScreen,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: widgets,
        ));
    return listView;
  }
}
