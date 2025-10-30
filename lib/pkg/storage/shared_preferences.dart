import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Singleton instance
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();

  // `late` digunakan untuk memastikan variabel diinisialisasi sebelum digunakan
  late final SharedPreferences _preferences;

  // Private constructor untuk Singleton
  SharedPreferencesHelper._internal();

  // Factory constructor untuk mengembalikan instance yang sama
  factory SharedPreferencesHelper() {
    return _instance;
  }

  // Inisialisasi SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Setter untuk menyimpan data String
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  // Getter untuk mendapatkan data String
  String? getString(String key) {
    return _preferences.getString(key);
  }

  // Hapus data berdasarkan key
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  // Hapus semua data
  Future<void> clear() async {
    await _preferences.clear();
  }
}
