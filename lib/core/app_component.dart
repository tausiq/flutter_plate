import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_plate/config/Env.dart';
import 'package:flutter_plate/generated/i18n.dart';
import 'package:flutter_plate/login/auth_bloc.dart';
import 'package:flutter_plate/util/log/Log.dart';

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
    Log.info('dispose');
    super.dispose();
    await _application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    final app = MaterialApp(
      title: Env.value.appName,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasylocaLizationDelegate(locale: data.locale, path: 'langs')
      ],
      supportedLocales: [Locale('en', 'US'), Locale('bn'), Locale('fr')],
      locale: data.savedLocale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Env.value.primarySwatch,
      ),
      onGenerateRoute: _application.router.generator,
    );
    print('initial core.route = ${app.initialRoute}');

    final localApp = EasyLocalizationProvider(
      data: data,
      child: app,
    );

    final appProvider = AppProvider(child: localApp, application: _application);
    return appProvider;
  }
}
