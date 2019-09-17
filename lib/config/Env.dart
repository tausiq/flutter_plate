import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/app/bloc/app_bloc_delegate.dart';
import 'package:flutter_plate/core/app_component.dart';
import 'package:flutter_plate/core/plate_app.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

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
    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.EARLY == environmentType ||
        EnvType.STAGING == environmentType) {
      Stetho.initialize();
      BlocSupervisor.delegate = AppBlocDelegate();
    }

    var application = PlateApp();
    await application.onCreate();
    runApp(EasyLocalization(child: AppComponent(application)));
  }
}
