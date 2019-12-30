import 'dart:async';

import 'package:flutter_plate/app/model/api/api_provider.dart';
import 'package:flutter_plate/app/model/db/db_app_store_repo.dart';
import 'package:flutter_plate/app/model/pojo/AppContent.dart';
import 'package:flutter_plate/app/model/pojo/Entry.dart';
import 'package:flutter_plate/app/model/pojo/response/LookupResponse.dart';
import 'package:flutter_plate/app/model/pojo/response/TopAppResponse.dart';
import 'package:rxdart/rxdart.dart';

class AppStoreAPIRepository {
  static const int TOP_100 = 100;
  static const int TOP_10 = 10;

  APIProvider _apiProvider;
  DBAppStoreRepository _dbAppStoreRepository;

  AppStoreAPIRepository(this._apiProvider, this._dbAppStoreRepository);

  Stream<List<AppContent>> getTop100FreeApp() {
    return Stream.fromFuture(_apiProvider.getTopFreeApp(TOP_100))
        .flatMap(_convertFromEntry)
        .flatMap((List<AppContent> list) {
      return Stream.fromFuture(_loadAndSaveTopFreeApp(list, ''));
    });
  }

  Stream<List<AppContent>> getTop10FeatureApp() {
    return Stream.fromFuture(_apiProvider.getTopFeatureApp(TOP_10))
        .flatMap(_convertFromEntry)
        .flatMap((List<AppContent> list) {
      return Stream.fromFuture(_loadAndSaveFeatureApp(list, ''));
    });
  }

  Stream<AppContent> getAppDetail(String id) {
    return Stream.fromFuture(_apiProvider.getAppDetail(id))
        .flatMap((LookupResponse response) {
      return Stream.value(response.results[0]);
    }).flatMap((AppContent appContent) {
      return Stream.fromFuture(_loadAndSaveAppDetail(appContent));
    });
  }

  Stream<List<AppContent>> _convertFromEntry(TopAppResponse response) {
    List<AppContent> appContent = [];
    for (Entry entry in response.feed.entry) {
      appContent.add(AppContent.fromEntry(entry));
    }
    return Stream.value(appContent);
  }

  Future<List<AppContent>> _loadAndSaveFeatureApp(
      List<AppContent> list, String searchKey) async {
    for (var i = 0; i < list.length; i++) {
      AppContent app = list[i];
      app.order = i;
      app.isFeatureApp = 1;
      await _dbAppStoreRepository.saveOrUpdateFeatureApp(app);
    }
    List<AppContent> appList =
        await _dbAppStoreRepository.loadFeaturesApp(searchKey);
    return appList;
  }

  Future<List<AppContent>> _loadAndSaveTopFreeApp(
      List<AppContent> list, String searchKey) async {
    for (var i = 0; i < list.length; i++) {
      AppContent app = list[i];
      app.order = i;
      app.isFreeApp = 1;
      await _dbAppStoreRepository.saveOrUpdateTopFreeApp(app);
    }
    List<AppContent> appList =
        await _dbAppStoreRepository.loadTopFreeApp(searchKey);
    return appList;
  }

  Future<AppContent> _loadAndSaveAppDetail(AppContent appContent) async {
    await _dbAppStoreRepository.saveOrUpdateDetailApp(appContent);
    AppContent appDb =
        await _dbAppStoreRepository.loadAppDetail(appContent.trackId);
    return appDb;
  }
}
