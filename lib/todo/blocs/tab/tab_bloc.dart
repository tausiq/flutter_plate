import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_plate/todo/model/app_tab.dart';

import './bloc.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
