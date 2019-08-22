import 'package:logger/logger.dart';

class Log {
  static const String _NAME = 'Plate';
  static Logger _instance;

  static void init() {
    Logger.addLogListener((callback) {
      print('${callback.level.toString()}: ${callback.error}: ${callback.message}');
    });
    _instance = Logger(
      printer: PrettyPrinter(),
    );
  }

  static void setLevel(Level level) {
    Logger.level = level;
  }

  static void v(message, [Object error, StackTrace stackTrace]) {
    _instance.v(message, error, stackTrace);
  }

  static void d(message, [Object error, StackTrace stackTrace]) {
    _instance.d(message, error, stackTrace);
  }

  static void i(message, [Object error, StackTrace stackTrace]) {
    _instance.i(message, error, stackTrace);
  }

  static void w(message, [Object error, StackTrace stackTrace]) {
    _instance.w(message, error, stackTrace);
  }

  static void e(message, [Object error, StackTrace stackTrace]) {
    _instance.e(message, error, stackTrace);
  }

  static void wtf(message, [Object error, StackTrace stackTrace]) {
    _instance.wtf(message, error, stackTrace);
  }
}
