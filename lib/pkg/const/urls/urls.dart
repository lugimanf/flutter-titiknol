import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static final String domain =
      dotenv.env['API_URL'] ?? 'https://localhost:8000';
  static const String login = "api/login";
  static const String loginConfirmOtp = "api/login/confirm-otp";
  static const String homeArticles = "api/articles";
  static const String books = "books";
  static const String authors = "authors";
  static const String publishers = "publishers";
  static const bool isHttps = false;
}
