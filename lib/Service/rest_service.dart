import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class RestConstants {
  RestConstants._privateConstructor();
  static final RestConstants instance = RestConstants._privateConstructor();
  final String BaseUrl =
      'https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf';
}

class RestServices {
  RestServices._privateConstructor();

  static final RestServices instance = RestServices._privateConstructor();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  void showRequestAndResponseLogs(
      http.Response? response, Map<String, Object> requestData) {
    logs('•••••••••• Network logs ••••••••••');
    logs('Request url --> ${response!.request!.url}');
    logs('Request headers --> $requestData');
    logs('Status code --> ${response.statusCode}');
    logs('Response headers --> ${response.headers}');
    logs('Response body --> ${response.body}');
    logs('••••••••••••••••••••••••••••••••••');
  }

  Future<String?>? getRestCall() async {
    String? responseData;
    try {
      String requestUrl = RestConstants.instance.BaseUrl;
      Uri? requestedUri = Uri.tryParse(requestUrl);

      headers['Content-Type'] = 'application/json';
      Response response = await http.get(requestedUri!, headers: headers);

      showRequestAndResponseLogs(response, headers);

      switch (response.statusCode) {
        case 200:
        case 201:
        case 400:
          responseData = response.body;
          break;
        case 207:
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          String errorMessage = responseMap['error'].toString();
          break;
        case 404:
        case 500:
        case 502:
          logs('${response.statusCode}');
          break;
        case 401:
          logs('401 : ${response.body}');
          break;
        default:
          logs('${response.statusCode} : ${response.body}');
          break;
      }
    } on PlatformException catch (e) {
      logs('PlatformException in getRestCall --> ${e.message}');
    }
    return responseData;
  }

  void logs(String message) {
    print(message);
  }
}
