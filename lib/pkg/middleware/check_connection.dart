import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:titiknol/pkg/helpers/connection_checker_helper.dart';

class ConnectionMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (ConnectionChecker.isConnected == false) {
      return const RouteSettings(name: '/noConnection');
    }
    return null; // lanjut kalau koneksi OK
  }
}
