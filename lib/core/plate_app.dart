import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_plate/app/model/api/api_provider.dart';
import 'package:flutter_plate/app/model/api/app_store_api_repo.dart';
import 'package:flutter_plate/app/model/db/app_db_migration_listener.dart';
import 'package:flutter_plate/app/model/db/db_app_store_repo.dart';
import 'package:flutter_plate/config/Env.dart';
import 'package:flutter_plate/repo/local/pref_repo.dart';
import 'package:flutter_plate/user/app_user.dart';
import 'package:flutter_plate/user/firebase_user_repository.dart';
import 'package:flutter_plate/util/db/DatabaseHelper.dart';
import 'package:flutter_plate/util/log/app_log.dart';
import 'package:logger/logger.dart';

import 'app_routes.dart';

abstract class Application {
  void onCreate();
  void onTerminate();
}

class PlateApp implements Application {
  FluroRouter router;
  DatabaseHelper _db;
  DBAppStoreRepository dbAppStoreRepository;
  AppStoreAPIRepository appStoreAPIRepository;
  FirebaseUserRepository userRepository;
  AppUser loggedInUser;
  PrefRepo prefRepo;

  @override
  Future<void> onCreate() async {
    await Firebase.initializeApp();
    _initLog();
    _initRouter();
    await _initDB();
    _initDBRepository();
    _initAPIRepository();
    _initUserRepository();
    _initPreference();
    _initMock();
  }

  @override
  Future<void> onTerminate() async {
    await _db.close();
  }

  Future<void> _initDB() async {
    AppDatabaseMigrationListener migrationListener = AppDatabaseMigrationListener();
    DatabaseConfig databaseConfig =
        DatabaseConfig(Env.value.dbVersion, Env.value.dbName, migrationListener);
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
    appStoreAPIRepository = AppStoreAPIRepository(apiProvider, dbAppStoreRepository);
  }

  void _initUserRepository() {
    userRepository = FirebaseUserRepository();
  }

  void _initPreference() async {
    prefRepo = PrefRepo();
    await prefRepo.init();
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

  void setLoggedInUser(AppUser user) {
    loggedInUser = user;
    // PrefService.setDefaultValues({'minutes_per_day_${user.id}': '30'});
  }

  void _initRouter() {
    router = FluroRouter();
    AppRoutes.configureRoutes(router);
  }

  Future<void> _initMock() async {
    if (!kReleaseMode) {
      // Init mock data
    }
  }
}
