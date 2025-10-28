import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/pkg/const/assets.dart' as const_assets;
import 'package:titiknol/pkg/globals/globals.dart' as globals;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      if (globals.token == null) {
        Get.offAllNamed("/login");
        return;
      }
      Get.offAllNamed("/mainMenu");
    });

    return MaterialApp(
      home: Scaffold(
        body: Image.asset(
          const_assets.imageSplashScreen,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
