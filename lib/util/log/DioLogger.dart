import 'package:dio/dio.dart';
import 'package:flutter_plate/util/log/Log.dart';

class DioLogger {
  static void onSend(String tag, RequestOptions options) {
    Log.i(
        '$tag - Request Path : [${options.method}] ${options.baseUrl}${options.path}');
    Log.i('$tag - Request Data : ${options.data.toString()}');
  }

  static void onSuccess(String tag, Response response) {
    Log.i(
        '$tag - Response Path : [${response.request.method}] ${response.request.baseUrl}${response.request.path} Request Data : ${response.request.data.toString()}');
    Log.i('$tag - Response statusCode : ${response.statusCode}');
    Log.i('$tag - Response data : ${response.data.toString()}');
  }

  static void onError(String tag, DioError error) {
    if (null != error.response) {
      Log.i(
          '$tag - Error Path : [${error.response.request.method}] ${error.response.request.baseUrl}${error.response.request.path} Request Data : ${error.response.request.data.toString()}');
      Log.i('$tag - Error statusCode : ${error.response.statusCode}');
      Log.i(
          '$tag - Error data : ${null != error.response.data ? error.response.data.toString() : ''}');
    }
    Log.i('$tag - Error Message : ${error.message}');
  }
}
