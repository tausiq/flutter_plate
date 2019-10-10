import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plate/app/model/api/user.dart';
import 'package:flutter_plate/app/model/api/user_repo.dart';
import 'package:flutter_plate/core/plate_app.dart';

class AppProvider extends InheritedWidget {
  final PlateApp application;

  AppProvider({Key key, Widget child, this.application})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static AppProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider);
  }

  static Router getRouter(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
        .application
        .router;
  }

  static PlateApp getApplication(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
        .application;
  }

  static User getUser(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider).application.loggedInUser;
  }

}
