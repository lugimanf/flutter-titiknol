import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:titiknol/apps/home/viewmodels/home.dart';
import 'package:titiknol/pkg/views/main_container/main_container.dart';
import 'package:titiknol/apps/home/views/widget_button_bento.dart';
import 'package:titiknol/apps/home/views/widget_articles.dart';
import 'package:titiknol/apps/home/views/widget_user_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    final WidgetArticles widgetArticles = WidgetArticles(context);
    final WidgetButtonBento widgetButtonBento = WidgetButtonBento(context);
    final WidgetUserInfo userInfo = WidgetUserInfo(context);

    return Scaffold(
      body: MainContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfo.userInfo(),
              const SizedBox(height: 20),
              widgetButtonBento.buttonBento(),
              widgetArticles.homeArticles(),
            ],
          ),
        ),
      ),
    );
  }
}
