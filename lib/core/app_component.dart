import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_plate/config/Env.dart';
import 'package:flutter_plate/generated/i18n.dart';
import 'package:flutter_plate/util/log/Log.dart';

import 'app_provider.dart';
import 'application_impl.dart';

class AppComponent extends StatefulWidget {
  final ApplicationImpl _application;

  AppComponent(this._application);

  @override
  State createState() => AppComponentState(_application);
}

class AppComponentState extends State<AppComponent> {
  final ApplicationImpl _application;

  AppComponentState(this._application);

  @override
  void dispose() async {
    Log.info('dispose');
    super.dispose();
    await _application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: Env.value.appName,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Env.value.primarySwatch,
      ),
      onGenerateRoute: _application.router.generator,
    );
    print('initial core.route = ${app.initialRoute}');

    final appProvider = AppProvider(child: app, application: _application);
    return appProvider;
  }
}
