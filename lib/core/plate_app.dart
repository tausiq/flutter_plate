import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter_plate/app/model/api/api_provider.dart';
import 'package:flutter_plate/app/model/api/app_store_api_repo.dart';
import 'package:flutter_plate/app/model/db/app_db_migration_listener.dart';
import 'package:flutter_plate/app/model/db/db_app_store_repo.dart';
import 'package:flutter_plate/config/Env.dart';
import 'package:flutter_plate/app/model/api/user_repo.dart';
import 'package:flutter_plate/util/db/DatabaseHelper.dart';
import 'package:flutter_plate/util/log/Log.dart';
import 'package:logging/logging.dart';

import 'Application.dart';
import 'app_routes.dart';

class PlateApp implements Application {
  Router router;
  DatabaseHelper _db;
  DBAppStoreRepository dbAppStoreRepository;
  AppStoreAPIRepository appStoreAPIRepository;
  UserRepository userRepository;

  @override
  Future<void> onCreate() async {
    _initLog();
    _initRouter();
    await _initDB();
    _initDBRepository();
    _initAPIRepository();
    _initUserRepository();
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
    Log.info('DB name : ' + Env.value.dbName);
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
    userRepository = UserRepository();
  }

  void _initLog() {
    Log.init();

    switch (Env.value.environmentType) {
      case EnvType.TESTING:
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:
        {
          Log.setLevel(Level.ALL);
          break;
        }
      case EnvType.PRODUCTION:
        {
          Log.setLevel(Level.INFO);
          break;
        }
    }
  }

  void _initRouter() {
    router = Router();
    AppRoutes.configureRoutes(router);
  }
}
