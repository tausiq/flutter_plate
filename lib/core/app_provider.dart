import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/core/plate_app.dart';
import 'package:flutter_plate/user/user.dart';

class AppProvider extends InheritedWidget {
  final PlateApp application;

  AppProvider({Key key, Widget child, this.application})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static AppProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>();
  }

  static Router getRouter(BuildContext context) {
    return getApplication(context).router;
  }

  static PlateApp getApplication(BuildContext context) {
    return of(context).application;
  }

  static User getUser(BuildContext context) {
    return getApplication(context).loggedInUser;
  }

}
