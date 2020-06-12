import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_plate/config/Env.dart';
import 'package:flutter_plate/util/log/app_log.dart';

import 'app_provider.dart';
import 'plate_app.dart';

class AppComponent extends StatefulWidget {
  final PlateApp _application;

  AppComponent(this._application);

  @override
  State createState() => AppComponentState(_application);
}

class AppComponentState extends State<AppComponent> {
  final PlateApp _application;

  AppComponentState(this._application);

  @override
  void dispose() async {
    Log.i('dispose');
    super.dispose();
    await _application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {

    final app = MaterialApp(
      title: Env.value.appName,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Env.value.primarySwatch,
      ),
      onGenerateRoute: _application.router.generator,
    );
    print('initial core.route = ${app.initialRoute}');

    final appProvider = AppProvider(child: app, application: _application);
    return appProvider;
  }
}
