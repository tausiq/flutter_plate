import 'package:bloc/bloc.dart';
import 'package:flutter_plate/util/log/app_log.dart';

class AppBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    Log.v('🔥 $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    String log =
        '⏮️ ${transition.currentState}\n🔥 ${transition.event}\n⏭️ ${transition.nextState}';
    Log.d(log);
  }

  @override
  void onError(Cubit bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    Log.e(error.toString() + bloc.toString(), error, stacktrace);
  }
}
