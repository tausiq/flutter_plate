import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  EnvType environmentType = EnvType.DEVELOPMENT;

  // Database Config
  int dbVersion = 1;
  String dbName;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.EARLY == environmentType ||
        EnvType.STAGING == environmentType) {
      Bloc.observer = AppBlocDelegate();
    }

    var application = PlateApp();
    await application.onCreate();

    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://dc5de6ddcd1d4cba8463ae0759aae869@o216731.ingest.sentry.io/5197447';
      },
      // Init your App.
      appRunner: () => runApp(EasyLocalization(supportedLocales: [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('bn', 'BD'),
      ], path: 'langs', child: AppComponent(application))),
    );
  }
}
