import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/pkg/helpers/connection_checker_helper.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text('Koneksi Anda bermasalah atau layanan sedang gangguan'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final isConnected = await ConnectionChecker.pingHost();
                if (isConnected) {
                  Get.offAllNamed('/'); // balik ke splash atau home
                } else {
                  Get.snackbar('Gagal', 'Masih belum ada koneksi');
                }
              },
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
