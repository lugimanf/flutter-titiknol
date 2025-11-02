import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:titiknol/apps/auth/viewmodels/fcm_token.dart';
import 'package:titiknol/pkg/storage/shared_preferences.dart';
import 'package:titiknol/pkg/views/loading_overlay/loading_overlay.dart';
import 'package:titiknol/pkg/globals/globals.dart' as globals;
import 'package:titiknol/pkg/const/keys.dart' as const_keys;
import 'package:titiknol/apps/splash/views/splash.dart';
import 'package:titiknol/apps/auth/views/login_form.dart';
import 'package:titiknol/apps/main_menu.dart';
import 'package:titiknol/pkg/helpers/debug_helper.dart';
import 'package:titiknol/pkg/firebase/firebase.dart';

late final SharedPreferencesHelper prefs;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await initializeFirebase();
  printDebug('🔔 Background message: ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  globals.version = packageInfo.version;
}

void init() {
  prefs = SharedPreferencesHelper();
  globals.token = prefs.getString(const_keys.jwtToken);
  globals.fcmToken = prefs.getString(const_keys.fcmToken);
  _getAppVersion();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //setup mendapatkan data dari env file
  const env =
      String.fromEnvironment('ENV', defaultValue: 'prod'); // default ke dev
  await dotenv.load(fileName: ".env.$env"); // misal .env.prod

  //setup penyimpanan lokal
  await SharedPreferencesHelper().init();

  //setup firebase
  // ✅ Wajib init Firebase sebelum runApp
  await initializeFirebase();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  const AndroidInitializationSettings initAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initIOS = DarwinInitializationSettings();
  const InitializationSettings initSettings =
      InitializationSettings(android: initAndroid, iOS: initIOS);
  await flutterLocalNotificationsPlugin.initialize(initSettings);
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FcmTokenViewModel fcmTokenViewModel = FcmTokenViewModel();

  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  Future<void> _initFCM() async {
    // 1. Minta izin
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    printDebug('🔐 Permission: ${settings.authorizationStatus}');

    // 2. Ambil token FCM (kirim ke server kalau perlu)
    printDebug("globals.fcmToken => ${globals.fcmToken}");
    if (globals.fcmToken == null) {
      String? fcmToken = await _messaging.getToken();
      if (fcmToken != null) {
        prefs.setString(const_keys.fcmToken, fcmToken);
        globals.fcmToken = fcmToken;
      }
    }

    // 2️⃣ Dengarkan event refresh (otomatis)
    _messaging.onTokenRefresh.listen((newFcmToken) {
      if (globals.token != null) {
        prefs.setString(const_keys.jwtToken, newFcmToken);
        globals.fcmToken = newFcmToken;
        fcmTokenViewModel.updateFcmTOken(newFcmToken);
      }
    });

    // 3. Listener saat app foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printDebug(
          '📩 Message received in foreground: ${message.notification?.title}');
      final notification = message.notification;
      if (notification != null && globals.token != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@drawable/ic_stat_titiknol',
            ),
          ),
        );
      }
    });

    // 4. Listener saat notifikasi diklik (app background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      printDebug('📲 App opened from notification: ${message.data}');
      // bisa diarahkan ke halaman tertentu di sini
    });
  }

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
