import 'dart:io';
import 'package:titiknol/pkg/app_config.dart';

class ConnectionChecker {
  static bool? isConnected;

  static Future<bool> pingHost(
      {Duration timeout = const Duration(seconds: 1)}) async {
    try {
      isConnected = false;
      final socket = await Socket.connect(
          AppConfig.url!.host, AppConfig.url!.port,
          timeout: timeout);

      socket.destroy();
      isConnected = true;
      return true;
    } catch (_) {
      return false;
    }
  }
}
