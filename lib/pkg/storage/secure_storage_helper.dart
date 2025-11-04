import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:titiknol/pkg/helpers/exception_helper.dart';

class FlutterSecureStorageHelper {
  // 🔒 Singleton instance
  static final FlutterSecureStorageHelper _instance =
      FlutterSecureStorageHelper._internal();

  late final FlutterSecureStorage _storage;

  // 🔒 Private constructor
  FlutterSecureStorageHelper._internal();

  // 🏗️ Factory constructor untuk mengembalikan instance yang sama
  factory FlutterSecureStorageHelper() {
    return _instance;
  }

  // 🚀 Inisialisasi Secure Storage
  Future<void> init() async {
    _storage = const FlutterSecureStorage();
  }

  // 📝 Setter untuk menyimpan data String
  Future<void> setString(String key, String value) async {
    try {
      return await _storage.write(key: key, value: value);
    } catch (e) {
      exceptionDialogBox(e, title: "error secure storage");
    }
  }

  // 📖 Getter untuk mendapatkan data String
  Future<String?> getString(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  // ❌ Hapus data berdasarkan key
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  // 🧹 Hapus semua data
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  // 📦 Baca semua data (opsional)
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  // ✅ Cek apakah key ada
  Future<bool> containsKey(String key) async {
    final all = await _storage.readAll();
    return all.containsKey(key);
  }
}
