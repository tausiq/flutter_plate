import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/core/plate_app.dart';
import 'package:flutter_plate/user/app_user.dart';

class AppProvider extends InheritedWidget {
  final PlateApp application;

  AppProvider({Key key, Widget child, this.application}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static AppProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>();
  }

  static FluroRouter getRouter(BuildContext context) {
    return getApplication(context).router;
  }

  static PlateApp getApplication(BuildContext context) {
    return of(context).application;
  }

  static AppUser getUser(BuildContext context) {
    return getApplication(context).loggedInUser;
  }
}
