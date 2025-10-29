import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRIS Scanner Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const QRISScannerPage(),
    );
  }
}

class QRISScannerPage extends StatefulWidget {
  const QRISScannerPage({super.key});
  @override
  State<QRISScannerPage> createState() => _QRISScannerPageState();
}

class _QRISScannerPageState extends State<QRISScannerPage> {
  String? result;
  bool isScanning = true;
  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _ensurePermission();
  }

  Future<void> _ensurePermission() async {
    final status = await Permission.camera.status;
    if (!status.isGranted) {
      final res = await Permission.camera.request();
      if (!res.isGranted) {
        // user menolak => beri tahu
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Izin Kamera Diperlukan'),
            content: const Text('Berikan izin kamera untuk memindai QRIS.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _onDetect(BarcodeCapture capture) {
    if (!isScanning) return;
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final code = barcodes.first.rawValue ?? '';
    if (code.isEmpty) return;

    // berhenti sementara supaya tidak double-scan
    setState(() {
      isScanning = false;
      result = code;
    });

    // contoh parse TLV sederhana
    final parsed = parseEMVQR(code);

    // tunjukan hasil
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Raw QR:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(code),
              const SizedBox(height: 12),
              const Text('Parsed TLV (some keys):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...parsed.entries.map((e) => Text('${e.key} => ${e.value}')),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => isScanning = true);
                },
                child: const Text('Scan lagi'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRIS Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: _onDetect,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(result == null ? 'Arahkan kamera ke QRIS' : 'Terbaca',
                      style: const TextStyle(color: Colors.white)),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = null;
                        isScanning = true;
                      });
                    },
                    child: const Text('Reset'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple TLV parser for EMV-style QR (Tag-Length-Value)
Map<String, String> parseEMVQR(String payload) {
  final Map<String, String> out = {};
  int i = 0;
  while (i < payload.length) {
    if (i + 2 > payload.length) break;
    final tag = payload.substring(i, i + 2);
    i += 2;
    if (i + 2 > payload.length) break;
    final lenStr = payload.substring(i, i + 2);
    i += 2;
    int len = int.tryParse(lenStr) ?? 0;
    if (i + len > payload.length) {
      // data malformed -> stop
      break;
    }
    final value = payload.substring(i, i + len);
    i += len;
    out[tag] = value;

    // For nested tags (like tag 62 or 26 often contain sub TLV),
    // try to parse basic nested TLV if present and append as combined keys.
    if ((tag == '62' || tag == '26' || tag == '30' || tag == '38') &&
        value.isNotEmpty) {
      // parse nested
      int j = 0;
      while (j < value.length) {
        if (j + 2 > value.length) break;
        final ntag = value.substring(j, j + 2);
        j += 2;
        if (j + 2 > value.length) break;
        final nlenStr = value.substring(j, j + 2);
        j += 2;
        final nlen = int.tryParse(nlenStr) ?? 0;
        if (j + nlen > value.length) break;
        final nval = value.substring(j, j + nlen);
        j += nlen;
        out['$tag.$ntag'] = nval;
      }
    }
  }
  return out;
}
