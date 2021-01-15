import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/core/app_bloc_delegate.dart';
import 'package:flutter_plate/core/app_component.dart';
import 'package:flutter_plate/core/plate_app.dart';
import 'package:sentry/sentry.dart';

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

  /// Sentry.io client used to send crash reports (or more generally "events").
  ///
  /// This client uses the default client parameters. For example, it uses a
  /// plain HTTP client that does not retry failed report attempts and does
  /// not support offline mode. You might want to use a different HTTP client,
  /// one that has these features. Please read the documentation for the
  /// [SentryClient] constructor to learn how you can customize it.
  ///
  /// [SentryClient.environmentAttributes] are particularly useful in a real
  /// app. Use them to specify attributes of your app that do not change from
  /// one event to another, such as operating system type and version, the
  /// version of Flutter, and [device information][1].
  ///
  /// [1]: https://github.com/flutter/plugins/tree/master/packages/device_info
  final SentryClient _sentry = SentryClient(
      dsn: "https://dc5de6ddcd1d4cba8463ae0759aae869@o216731.ingest.sentry.io/5197447");

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

    // This captures errors reported by the Flutter framework.
    FlutterError.onError =
        (FlutterErrorDetails details, {bool forceReport = false}) async {
      if (!kReleaseMode) {
        // In development mode simply print to console.
        FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
      } else {
        // In production mode report to the application zone to report to
        // Sentry.
        Zone.current.handleUncaughtError(details.exception, details.stack);
      }
    };

    // This creates a [Zone] that contains the Flutter application and stablishes
    // an error handler that captures errors and reports them.
    //
    // Using a zone makes sure that as many errors as possible are captured,
    // including those thrown from [Timer]s, microtasks, I/O, and those forwarded
    // from the `FlutterError` handler.
    //
    // More about zones:
    //
    // - https://api.dartlang.org/stable/1.24.2/dart-async/Zone-class.html
    // - https://www.dartlang.org/articles/libraries/zones
    runZoned<Future<Null>>(() async {
      runApp(EasyLocalization(supportedLocales: [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('bn', 'BD'),
      ], path: 'langs', child: AppComponent(application)));
    }, onError: (error, stackTrace) async {
      await _reportError(error, stackTrace);
    });
  }

  /// Reports [error] along with its [stackTrace] to Sentry.io.
  Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
    print('Caught error: $error');

    // Errors thrown in development mode are unlikely to be interesting. You can
    // check if you are running in dev mode using an assertion and omit sending
    // the report.
    if (!kReleaseMode) {
      print(stackTrace);
      print('In dev mode. Not sending report to Sentry.io.');
      return;
    }

    print('Reporting to Sentry.io...');

    try {
      final SentryResponse response = await _sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
      if (response.isSuccessful) {
        print('Success! Event ID: ${response.eventId}');
      } else {
        print('Failed to report to Sentry.io: ${response.error}');
      }
    } catch (e) {
      print('Sending report to sentry.io failed: $e');
      print('Original error: $error');
    }
  }
}
