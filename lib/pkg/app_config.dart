import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:titiknol/pkg/const/keys.dart' as const_keys;
import 'package:titiknol/pkg/storage/secure_storage_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Url {
  final String domain;
  late final String host;
  late final int port;

  Url(this.domain) {
    final parts = domain.split(':');
    host = parts[0];
    port = parts.length > 1 ? int.tryParse(parts[1]) ?? 80 : 80;
  }
}

class User {
  String? jwtToken;
  String? fcmToken;

  User(FlutterSecureStorageHelper prefs) {
    prefs.getString(const_keys.jwtToken).then((v) => jwtToken = v);
    prefs.getString(const_keys.fcmToken).then((v) => fcmToken = v);
  }
}

class AppConfig {
  static Url? url;
  static User? user;
  static String? version;

  static Future<void> init(FlutterSecureStorageHelper prefs) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    url = Url(dotenv.env['API_URL']!);
    user = User(prefs);
  }
}
