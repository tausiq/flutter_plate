import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/app/bloc/app_bloc_delegate.dart';
import 'package:flutter_plate/app/model/core/app_component.dart';
import 'package:flutter_plate/app/model/core/app_store_application.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

enum EnvType { DEVELOPMENT, STAGING, PRODUCTION, TESTING }

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
    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.STAGING == environmentType) {
      Stetho.initialize();
      BlocSupervisor.delegate = AppBlocDelegate();
    }

    var application = AppStoreApplication();
    await application.onCreate();
    runApp(AppComponent(application));
  }
}
