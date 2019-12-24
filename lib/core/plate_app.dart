import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter_plate/app/model/api/api_provider.dart';
import 'package:flutter_plate/app/model/api/app_store_api_repo.dart';
import 'package:flutter_plate/user/user.dart';
import 'package:flutter_plate/app/model/db/app_db_migration_listener.dart';
import 'package:flutter_plate/app/model/db/db_app_store_repo.dart';
import 'package:flutter_plate/config/Env.dart';
import 'package:flutter_plate/settings/prefs_const.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
import 'package:flutter_plate/util/db/DatabaseHelper.dart';
import 'package:flutter_plate/util/log/Log.dart';
import 'package:logger/logger.dart';
import 'package:preferences/preferences.dart';

import 'Application.dart';
import 'app_routes.dart';

class PlateApp implements Application {
  Router router;
  DatabaseHelper _db;
  DBAppStoreRepository dbAppStoreRepository;
  AppStoreAPIRepository appStoreAPIRepository;
  FirebaseUserRepository userRepository;
  User loggedInUser;

  @override
  Future<void> onCreate() async {
    _initLog();
    _initRouter();
    await _initDB();
    _initDBRepository();
    _initAPIRepository();
    _initUserRepository();
    _initPreference();
  }

  @override
  Future<void> onTerminate() async {
    await _db.close();
  }

  Future<void> _initDB() async {
    AppDatabaseMigrationListener migrationListener =
        AppDatabaseMigrationListener();
    DatabaseConfig databaseConfig = DatabaseConfig(
        Env.value.dbVersion, Env.value.dbName, migrationListener);
    _db = DatabaseHelper(databaseConfig);
    Log.i('DB name : ' + Env.value.dbName);
//    await _db.deleteDB();
    await _db.open();
  }

  void _initDBRepository() {
    dbAppStoreRepository = DBAppStoreRepository(_db.database);
  }

  void _initAPIRepository() {
    APIProvider apiProvider = APIProvider();
    appStoreAPIRepository =
        AppStoreAPIRepository(apiProvider, dbAppStoreRepository);
  }

  void _initUserRepository() {
    userRepository = FirebaseUserRepository();
  }

  void _initPreference() async {
    await PrefService.init(prefix: PREF_PREFIX);
    PrefService.setDefaultValues({WORKOUT_MIN_PER_DAY: '60'});
  }


  void _initLog() {
    Log.init();

    switch (Env.value.environmentType) {
      case EnvType.EARLY:
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:
        {
          Log.setLevel(Level.verbose);
          break;
        }
      case EnvType.PRODUCTION:
        {
          Log.setLevel(Level.info);
          break;
        }
    }
  }

  void setLoggedInUser(User user) {
    loggedInUser = user;
    PrefService.setDefaultValues({'minutes_per_day_${user.id}': '30'});
  }

  void _initRouter() {
    router = Router();
    AppRoutes.configureRoutes(router);
  }
}
