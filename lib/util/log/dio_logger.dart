import 'package:dio/dio.dart';
import 'package:flutter_plate/util/log/app_log.dart';

class DioLogger {
  static void onSend(RequestOptions options) {
    String log = '[${options.method}]: ${options.baseUrl}${options.path}';
    if (options.data != null) {
      log += '\nData: ${options.data.toString()}';
    }
    Log.v(log);
  }

  static void onSuccess(Response response) {
    String log = '[${response.request.method}]: ${response.request.baseUrl}${response
        .request.path}';
    if (response.request.data != null) {
      log += '\nData: ${response.request.data.toString()}';
    }
    log += '\nResponse: ${response.statusCode} [${response.statusMessage}]';
    log += '\nData: ${response.data.toString()}';
    Log.d(log);
  }

  static void onError(DioError error) {
    String log = 'Error: ${error.message}';
    if (null != error.response) {
      log += '\n[${error.response.request.method}]: ${error.response.request
          .baseUrl}${error.response.request.path}';

      if (error.response.request.data != null) {
        log += '\nData: ${error.response.request.data.toString()}';
      }
      log += '\nResponse: ${error.response.statusCode} [${error.response.statusMessage}]';

      if (error.response.data != null) {
        log += '\nData: ${error.response.data.toString()}';
      }
    }
    Log.e(log);
  }
}
