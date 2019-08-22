import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plate/app/ui/page/app_detail_page.dart';
import 'package:flutter_plate/app/ui/page/app_store_page.dart';
import 'package:flutter_plate/core/app_provider.dart';
import 'package:flutter_plate/counter/counter_page.dart';
import 'package:flutter_plate/home/home_page.dart';
import 'package:flutter_plate/login/auth_page.dart';
import 'package:flutter_plate/timer/bloc/bloc.dart';
import 'package:flutter_plate/timer/ticker.dart';
import 'package:flutter_plate/timer/timer_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

var authRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AuthPage(
    userRepository: AppProvider.getApplication(context).userRepository,
  );
});

var appStoreRouteHander = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AppStorePage();
});

var counterRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CounterPage();
});

var timerRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BlocProvider(
    builder: (context) => TimerBloc(ticker: Ticker()),
    child: TimerPage(),
  );
});

var appDetailRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String appId = params['appId']?.first;
  String heroTag = params['heroTag']?.first;
  String title = params['title']?.first;
  String url = params['url']?.first;
  String titleTag = params['titleTag']?.first;

  return AppDetailPage(
      appId: num.parse(appId),
      heroTag: heroTag,
      title: title,
      url: url,
      titleTag: titleTag);
});

class AppRoutes {
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ROUTE WAS NOT FOUND !!!');
    });
    router.define(AuthPage.PATH, handler: authRouteHandler);
    router.define(HomePage.PATH, handler: rootHandler);
    router.define(AppStorePage.PATH, handler: appStoreRouteHander);
    router.define(AppDetailPage.PATH, handler: appDetailRouteHandler);
    router.define(CounterPage.PATH,
        handler: counterRouteHandler, transitionType: TransitionType.fadeIn);
    router.define(TimerPage.PATH,
        handler: timerRouteHandler,
        transitionType: TransitionType.inFromBottom);
  }
}
