import 'package:flutter/material.dart';
import 'package:flutter_plate/app/model/core/AppProvider.dart';
import 'package:flutter_plate/app/model/core/AppStoreApplication.dart';
import 'package:flutter_plate/config/Env.dart';
import 'package:flutter_plate/generated/i18n.dart';
import 'package:flutter_plate/util/log/Log.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class AppComponent extends StatefulWidget {

  final AppStoreApplication _application;

  AppComponent(this._application);

  @override
  State createState() {
    return new AppComponentState(_application);
  }
}

class AppComponentState extends State<AppComponent> {

  final AppStoreApplication _application;

  AppComponentState(this._application);

  @override
  void dispose()async{
    Log.info('dispose');
    await _application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {

    final app = new MaterialApp(
        title: Env.value.appName,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Env.value.primarySwatch,
        ),
        onGenerateRoute: _application.router.generator,
    );
    print('initial core.route = ${app.initialRoute}');

    final appProvider = AppProvider(child: app, application: _application);
    return appProvider;
  }
}