import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:titiknol/pkg/storage/shared_preferences.dart';
import 'package:titiknol/pkg/views/loading_overlay/loading_overlay.dart';
import 'package:titiknol/pkg/globals/globals.dart' as globals;
import 'package:titiknol/pkg/const/keys.dart' as const_keys;
import 'package:titiknol/apps/splash/views/splash.dart';
import 'package:titiknol/apps/auth/views/login_form.dart';
import 'package:titiknol/apps/main_menu.dart';

Future<void> _getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  globals.version = packageInfo.version;
}

void init() {
  final prefs = SharedPreferencesHelper();
  globals.token = prefs.getString(const_keys.jwtToken);
  _getAppVersion();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const env =
      String.fromEnvironment('ENV', defaultValue: 'prod'); // default ke dev
  await dotenv.load(fileName: ".env.$env"); // misal .env.prod
  await SharedPreferencesHelper().init();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(initialRoute: '/', getPages: [
      GetPage(name: '/', page: () => const SplashScreen()),
      GetPage(
          name: '/mainMenu',
          page: () => const LoadingOverlay(child: MainMenu())),
      GetPage(
          name: '/login', page: () => const LoadingOverlay(child: LoginForm())),
    ]);
  }
}
