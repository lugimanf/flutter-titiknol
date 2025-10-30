import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:titiknol/pkg/const/urls/urls.dart';
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/const/https.dart' as const_https;
import 'package:titiknol/pkg/globals/globals.dart' as globals;

const int statusCodeSuccess = 1;
const int statusCodeBadRequest = 0;
const int statusCodeRedirectToLogin = 4;
const String errorMessageUrlNotSet =
    "please insert url first to get data from server";

class HttpHelper {
  Map<String, dynamic>? data;
  String? _url;

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'version': globals.version,
    'platform': const_https.platformUsed,
  };

  String? _body;

  void setUrl(String domain, path,
      {Map<String, dynamic> parameter = const {}}) {
    Uri url;
    if (Urls.isHttps) {
      if (parameter == {}) {
        url = Uri.https(domain, path, parameter);
      } else {
        url = Uri.https(domain, path);
      }
    } else {
      if (parameter == {}) {
        url = Uri.http(domain, path, parameter);
      } else {
        url = Uri.http(domain, path);
      }
    }

    _url = url.toString();
  }

  void addHeaders(String key, value) {
    _headers[key] = value;
  }

  void setBody(String body) {
    _body = body;
  }

  Future<Map<String, dynamic>> post() async {
    try {
      if (_url?.isEmpty == true) {
        return {
          "message": errorMessageUrlNotSet,
        };
      }
      if (globals.token?.isEmpty == false) {
        _headers['Authorization'] = "Bearer ${globals.token}";
      }
      final response = await http
          .post(
            Uri.parse(_url.toString()),
            headers: _headers,
            body: _body,
          )
          .timeout(const Duration(seconds: const_https.timeOutHTTP));
      return processResponse(response);
    } catch (e) {
      return errorException(e);
    }
  }

  Future<Map<String, dynamic>> get({Map<String, String>? queryParams}) async {
    try {
      if (_url?.isEmpty == true) {
        return {
          "message": errorMessageUrlNotSet,
        };
      }
      if (globals.token?.isEmpty == false) {
        _headers['Authorization'] = "Bearer ${globals.token}";
      }
      // final uri = Uri.parse(_url!).replace(
      //   queryParameters: queryParams?.map(
      //     (key, value) => MapEntry(key, value.toString()),
      //   ),
      // );
      final response = await http
          .get(
            Uri.parse(_url!),
            headers: _headers,
          )
          .timeout(const Duration(seconds: const_https.timeOutHTTP));
      return processResponse(response);
    } catch (e) {
      return errorException(e);
    }
  }

  Map<String, dynamic> processResponse(response) {
    data = jsonDecode(response.body);
    switch (checkStatusCode(response.statusCode)) {
      case statusCodeRedirectToLogin:
        Get.offAllNamed('/login');
        break;
      case statusCodeBadRequest:
        Get.defaultDialog(
          title: "Info",
          middleText: "Terjadi kesalahan saat mengirim / menerima",
          textConfirm: "OK",
          onConfirm: () => Get.back(),
        );
    }
    return data!;
  }

  Map<String, dynamic> errorException(Object e) {
    String error = "";
    if (e is SocketException) {
      error = const_https.errorSocketException;
    } else if (e is TimeoutException) {
      error = const_https.errorRTO;
    } else if (e is http.ClientException) {
      if (e.message.contains(const_https.httpMessageErrorConnectionByPeer) ||
          e.message.contains(const_https.httpMessageErrorConnectionRefused)) {
        error = const_https.errorSocketException;
      } else {
        error = const_https.errorClietException;
      }
    } else if (e is CertificateException || e is HandshakeException) {
      error = const_https.errorClietException;
    } else {
      error = const_labels.errorDefault + e.toString();
    }
    return {
      'message': error,
    };
  }

  int checkStatusCode(int statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        return statusCodeBadRequest; //means status error so show message error from server
      case HttpStatus.forbidden:
      case HttpStatus.unauthorized:
        return statusCodeRedirectToLogin; //means apps must route to page login because don't have access
    }
    return statusCodeSuccess; //means status sucess
  }
}
