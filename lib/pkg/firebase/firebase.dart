import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:titiknol/pkg/helpers/debug_helper.dart';

// kamu bisa ubah ke 'prod' / 'dev' sesuai env
const bool useManualFirebaseOptions = true;

Future<void> initializeFirebase() async {
  try {
    if (useManualFirebaseOptions) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_API_KEY']!,
          appId: dotenv.env['FIREBASE_APP_ID']!,
          messagingSenderId:
              dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
          projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
          storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
        ),
      );
    } else {
      await Firebase.initializeApp(); // pakai google-services.json
    }

    printDebug("✅ Firebase initialized successfully");
  } catch (e) {
    printDebug("❌ Firebase init failed: $e");
  }
}
