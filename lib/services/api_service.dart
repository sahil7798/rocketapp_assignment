import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rocketapp_assignment/services/app_exceptions.dart';
import 'package:rocketapp_assignment/services/base_api.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection ');
    }
    if (kDebugMode) {
      print("$responseJson");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw FetchDataException('Page not found. Check the URL!');
      case 500:
        throw BadRequestException(response.body.toString());

      //break;
      default:
        throw FetchDataException(
            'Error occured while communicating with server');
    }
  }
}
