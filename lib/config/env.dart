import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plate/constants/const.dart';
import 'package:flutter_plate/core/app_bloc_delegate.dart';
import 'package:flutter_plate/core/app_component.dart';
import 'package:flutter_plate/core/plate_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

enum EnvType { DEVELOPMENT, STAGING, PRODUCTION, EARLY }

class Env {
  static Env value;

  String appName;
  String baseUrl;
  Color primarySwatch;
  EnvType environmentType;

  // Database Config
  int dbVersion = 1;
  String dbName;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await setPreferredOrientations();

    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.EARLY == environmentType ||
        EnvType.STAGING == environmentType) {
      Bloc.observer = AppBlocDelegate();
    }

    var application = PlateApp();
    await application.onCreate();

    await SentryFlutter.init(
      (options) {
        options.dsn = Const.dnsSentry;
      },
      // Init your App.
      appRunner: () => runApp(EasyLocalization(
          supportedLocales: Const.supportedLocales,
          path: Const.languagePath,
          child: AppComponent(application))),
    );
  }

  Future<void> setPreferredOrientations() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}
