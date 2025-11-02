import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static final String domain =
      dotenv.env['API_URL'] ?? 'https://localhost:8000';
  static const String login = "api/login";
  static const String loginConfirmOtp = "api/login/confirm-otp";
  static const String articles = "api/articles";
  static const String books = "books";
  static const String authors = "authors";
  static const String publishers = "publishers";
  static const String user = "api/user";
  static const String userUpdateFcmToken = "api/user/fcm-token";
  static const String insertVoucher = "api/user/voucher";
  static const String vouchers = "api/vouchers";
  static const String voucherByID = "api/voucher/";
  static const bool isHttps = false;
}
