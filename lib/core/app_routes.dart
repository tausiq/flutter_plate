import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/app/ui/page/app_detail_page.dart';
import 'package:flutter_plate/app/ui/page/app_store_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AppStorePage();
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
    router.define(AppStorePage.PATH, handler: rootHandler);
    router.define(AppDetailPage.PATH, handler: appDetailRouteHandler);
  }
}
