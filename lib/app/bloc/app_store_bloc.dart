import 'dart:async';

import 'package:flutter_plate/app/model/api/app_store_api_repo.dart';
import 'package:flutter_plate/app/model/pojo/AppContent.dart';
import 'package:flutter_plate/core/plate_app.dart';
import 'package:flutter_plate/util/log/Log.dart';
import 'package:rxdart/rxdart.dart';

class AppStoreBloc {
  final PlateApp _application;
  final _searchText = BehaviorSubject<String>();
  final _feedList = BehaviorSubject<List<HomeListItem>>();
  final _isShowLoading = BehaviorSubject<bool>();
  final _noticeItemUpdate = BehaviorSubject<num>();
  List<HomeListItem> appList;

  AppStoreBloc(this._application) {
    _init();
  }

  CompositeSubscription _compositeSubscription = CompositeSubscription();
  Stream<bool> get isShowLoading => _isShowLoading.stream;
  Stream<String> get searchText => _searchText.stream;
  Stream<List<HomeListItem>> get feedList => _feedList.stream;
  Stream<num> get noticeItemUpdate => _noticeItemUpdate.stream;

  var loadedMap = {};

  void _init() {
    // Debounce search text
    _searchText
        .debounceTime(const Duration(milliseconds: 500))
        .listen((String searchText) {
      _searchApps(searchText);
    });
  }

  void dispose() {
    _compositeSubscription.clear();
    _searchText.close();
    _feedList.close();
    _isShowLoading.close();
    _noticeItemUpdate.close();
  }

  void changeSearchText(String searchTxt) {
    _searchText.add(searchTxt);
  }

  void loadFeedList() {
    _isShowLoading.add(true);
    AppStoreAPIRepository apiProvider = _application.appStoreAPIRepository;

    StreamSubscription subscription = Stream.fromFuture(
            _application.dbAppStoreRepository.deleteAllAppContent())
        .flatMap((_) => apiProvider.getTop10FeatureApp())
        .zipWith(apiProvider.getTop100FreeApp(),
            (List<AppContent> featureApps, List<AppContent> freeApps) {
      return CombinedAppResponse(featureApps, freeApps);
    }).listen((CombinedAppResponse response) {
      if (null != appList) {
        appList.clear();
      }
      appList = List<HomeListItem>();

      appList.add(FeatureListItem(response.featureApps));

      List<AppContent> entries = response.freeApps;

      for (var i = 0; i < entries.length; i++) {
        appList.add(TopAppListItem(entries[i]));
      }
      _feedList.add(appList);
      _isShowLoading.add(false);
    }, onError: (e, s) {
      Log.i(e);
    });
    _compositeSubscription.add(subscription);
  }

  void _searchApps(String searchKey) {
    StreamSubscription subscription = Stream.fromFuture(
            _application.dbAppStoreRepository.loadFeaturesApp(searchKey))
        .zipWith(
            Stream.fromFuture(
                _application.dbAppStoreRepository.loadTopFreeApp(searchKey)),
            (List<AppContent> featureApps, List<AppContent> freeApps) {
      return CombinedAppResponse(featureApps, freeApps);
    }).listen((CombinedAppResponse response) {
      appList.clear();

      if (response.featureApps.length > 0) {
        appList.add(FeatureListItem(response.featureApps));
      }

      if (response.freeApps.length > 0) {
        List<AppContent> entries = response.freeApps;
        for (var i = 0; i < entries.length; i++) {
          appList.add(TopAppListItem(entries[i]));
        }
      }
      _feedList.add(appList);
    }, onError: (e, s) {
      Log.i(e);
    });
    _compositeSubscription.add(subscription);
  }

  void loadDetailInfo(int index) {
    if (appList.length == 0 || appList.length <= index) {
      return;
    }

    HomeListItem listItem = appList[index];

    if (HomeListType.TYPE_TOP_APP == listItem.type) {
      TopAppListItem freeAppListItem = listItem;

      if (null != loadedMap[freeAppListItem.entry.trackId] &&
          loadedMap[freeAppListItem.entry.trackId]) {
        return;
      }

      loadedMap[freeAppListItem.entry.trackId] = true;

      StreamSubscription subscription = _application.appStoreAPIRepository
          .getAppDetail(freeAppListItem.entry.trackId.toString())
          .listen((AppContent appContent) {
        freeAppListItem.entry = appContent;
        _noticeItemUpdate.add(appContent.trackId);
      });
      _compositeSubscription.add(subscription);
    }
  }
}

class CombinedAppResponse {
  List<AppContent> featureApps;
  List<AppContent> freeApps;

  CombinedAppResponse(this.featureApps, this.freeApps);
}

enum HomeListType { TYPE_FEATURE, TYPE_TOP_APP }

abstract class HomeListItem {
  HomeListType type;

  HomeListItem(this.type);

  num getId();
}

class FeatureListItem extends HomeListItem {
  List<AppContent> entryList;

  FeatureListItem(this.entryList) : super(HomeListType.TYPE_FEATURE);

  @override
  num getId() {
    if (entryList.length > 0) {
      return entryList[0].trackId;
    }
    return -1;
  }
}

class TopAppListItem extends HomeListItem {
  AppContent entry;
  TopAppListItem(this.entry) : super(HomeListType.TYPE_TOP_APP);

  @override
  num getId() {
    return entry.trackId;
  }
}
