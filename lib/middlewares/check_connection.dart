import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class ConnectionMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return _checkConnection();
  }

  Future<bool> pingHost(String host, int port,
      {Duration timeout = const Duration(seconds: 2)}) async {
    try {
      final socket = await Socket.connect(host, port, timeout: timeout);
      socket.destroy();
      return true;
    } catch (e) {
      return false;
    }
  }

  RouteSettings? _checkConnection() {
    try {
      InternetAddress.lookup('google.com');
      return null; // koneksi OK → lanjut ke view
    } catch (_) {
      return const RouteSettings(
          name: '/no_connection'); // redirect ke halaman error
    }
  }
}
