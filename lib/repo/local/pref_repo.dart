import 'dart:async';

import 'package:preferences/preference_service.dart';

class PrefRepo {
  static const String _PREF_PREFIX = 'flutter_plate';
  static const String _WORKOUT_MIN_PER_DAY = 'workout_min_per_day';
  static const String _TOKEN = 'token';
  static const String _USER_ID = 'user_id';

  Future<void> init() async {
    await PrefService.init(prefix: _PREF_PREFIX);
    setDefaultValues();
  }

  void setDefaultValues() async {
    PrefService.setDefaultValues({_WORKOUT_MIN_PER_DAY: '60'});
  }

  String userId({String userId}) {
    if (userId == null)
      return PrefService.getString(_USER_ID);
    else {
      PrefService.setString(_USER_ID, userId);
      return userId;
    }
  }
}
